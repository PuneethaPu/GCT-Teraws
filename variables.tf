variable "aws_region" {
  description = "AWS region in which to create enabled services."
  type        = string
  default     = "us-east-1"
}

variable "enable_ec2" {
  description = "Whether to create one EC2 instance."
  type        = bool
  default     = false
}

variable "ec2_ami_id" {
  description = "AMI ID for the EC2 instance. Required when enable_ec2 is true."
  type        = string
  default     = null
  nullable    = true
}

variable "ec2_instance_type" {
  description = "EC2 instance type."
  type        = string
  default     = "t3.micro"
}

variable "ec2_subnet_id" {
  description = "Optional existing subnet ID for the EC2 instance."
  type        = string
  default     = null
  nullable    = true
}

variable "ec2_security_group_ids" {
  description = "Optional existing security group IDs for the EC2 instance."
  type        = list(string)
  default     = []
}

variable "ec2_associate_public_ip_address" {
  description = "Whether to associate a public IP with the EC2 instance."
  type        = bool
  default     = false
}

variable "ec2_iam_instance_profile" {
  description = "Optional existing IAM instance profile name for the EC2 instance."
  type        = string
  default     = null
  nullable    = true
}

variable "enable_s3" {
  description = "Whether to create an S3 bucket."
  type        = bool
  default     = false
}

variable "s3_bucket_name" {
  description = "Globally unique S3 bucket name. Required when enable_s3 is true."
  type        = string
  default     = null
  nullable    = true
}

variable "s3_enable_versioning" {
  description = "Whether to enable S3 bucket versioning."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags applied to created AWS resources."
  type        = map(string)
  default     = {}
}
