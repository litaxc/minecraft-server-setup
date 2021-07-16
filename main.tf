terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.18.0"
    }
    local = {
      version = "~> 2.0.0"
    }
  }
  backend "local" {}
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "all" {
  vpc_id = data.aws_vpc.default.id
}


data "aws_ami" "base_image" {
  most_recent = true
  owners      = ["099720109477"]
  name_regex  = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-arm64-server-*"
}

data "aws_s3_bucket" "backup" {
  bucket = var.s3_bucket
}

resource "aws_iam_user" "minecraft" {
  name = "minecraft"
}

resource "aws_iam_user_policy" "minecraft" {
  name = "minecraft"
  user = aws_iam_user.minecraft.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:PutObject",
      "Resource": "arn:aws:s3:::${data.aws_s3_bucket.backup.arn}/${var.backup_path}/*"
    }
  ]
}
EOF
}

resource "aws_iam_access_key" "minecraft" {
  user = aws_iam_user.minecraft.name
}

resource "aws_security_group" "minecraft" {
  name        = "Minecraft"
  description = "Security group for Minecraft server"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  ingress {
    from_port   = 25565
    to_port     = 25565
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidrs
  }
  ingress {
    from_port   = 25565
    to_port     = 25565
    protocol    = "udp"
    cidr_blocks = var.allowed_cidrs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "minecraft" {
  ami                         = data.aws_ami.base_image.id
  instance_type               = "t4g.small"
  vpc_security_group_ids      = [aws_security_group.minecraft.id]
  associate_public_ip_address = true
  subnet_id                   = tolist(data.aws_subnet_ids.all.ids)[0]
  key_name                    = var.ssh_private_key

  tags = {
    Name = "Minecraft"
  }

  root_block_device {
    delete_on_termination = false
    volume_type           = "gp2"
    volume_size           = 8
  }
}
