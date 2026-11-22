output "ec2_instance_id" {
  description = "ID of the created EC2 instance, or null when EC2 is disabled."
  value       = try(aws_instance.this[0].id, null)
}

output "ec2_public_ip" {
  description = "Public IP of the created EC2 instance, or null when EC2 is disabled or has no public IP."
  value       = try(aws_instance.this[0].public_ip, null)
}

output "s3_bucket_name" {
  description = "Name of the created S3 bucket, or null when S3 is disabled."
  value       = try(aws_s3_bucket.this[0].bucket, null)
}
