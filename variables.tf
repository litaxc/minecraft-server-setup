variable "aws_profile" {
  description = "The AWS profile to use."
}
variable "aws_region" {
  description = "AWS region to deploy to."
}

variable "ssh_private_key" {
  description = "Private key to use to connect to hosts. This should be the same key as 'key_name' defined in main.tf."
}

