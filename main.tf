resource "aws_instance" "this" {
  count = var.enable_ec2 ? 1 : 0

  ami                         = var.ec2_ami_id
  instance_type               = var.ec2_instance_type
  subnet_id                   = var.ec2_subnet_id
  vpc_security_group_ids      = var.ec2_security_group_ids
  associate_public_ip_address = var.ec2_associate_public_ip_address
  iam_instance_profile        = var.ec2_iam_instance_profile

  root_block_device {
    encrypted             = true
    volume_type           = "gp3"
    delete_on_termination = true
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
  }

  tags = merge(var.tags, {
    Name = "terraform-aws-services-ec2"
  })

  lifecycle {
    precondition {
      condition     = try(trimspace(var.ec2_ami_id) != "", false)
      error_message = "Set ec2_ami_id to a valid AMI ID when enable_ec2 is true."
    }
  }
}

resource "aws_s3_bucket" "this" {
  count = var.enable_s3 ? 1 : 0

  bucket        = var.s3_bucket_name
  force_destroy = false

  tags = merge(var.tags, {
    Name = "terraform-aws-services-s3"
  })

  lifecycle {
    precondition {
      condition     = try(trimspace(var.s3_bucket_name) != "", false)
      error_message = "Set s3_bucket_name to a globally unique bucket name when enable_s3 is true."
    }
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  count = var.enable_s3 ? 1 : 0

  bucket                  = aws_s3_bucket.this[0].id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  count = var.enable_s3 ? 1 : 0

  bucket = aws_s3_bucket.this[0].id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_ownership_controls" "this" {
  count = var.enable_s3 ? 1 : 0

  bucket = aws_s3_bucket.this[0].id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_versioning" "this" {
  count = var.enable_s3 && var.s3_enable_versioning ? 1 : 0

  bucket = aws_s3_bucket.this[0].id

  versioning_configuration {
    status = "Enabled"
  }
}
