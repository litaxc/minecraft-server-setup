variable "aws_profile" {
  description = "The AWS profile to use."
}
variable "aws_region" {
  description = "AWS region to deploy to."
}
variable "s3_bucket" {
  description = "The s3 bucket and path for backup."
}
variable "backup_path" {
  description = "The path under s3 bucket for backup."
}

variable "ssh_private_key" {
  description = "Private key to use to connect to hosts. This should be the same key as 'key_name' defined in main.tf."
}

variable "allowed_cidrs" {
  type        = list(string)
  description = "Only allow these IPs to connect to our Minecraft server."
}
