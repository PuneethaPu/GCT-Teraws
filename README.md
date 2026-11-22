# Terraform AWS Services

A small Terraform project for optionally creating one AWS EC2 instance and one
S3 bucket. Each service is controlled independently with a variable. Both
services are disabled by default, so an unmodified configuration creates no
AWS resources.

## Requirements

- Terraform 1.5 or later
- An AWS account and credentials configured through the standard AWS provider
  credential chain (environment variables, shared config, or an assigned role)

Do not put AWS access keys in Terraform files or `terraform.tfvars`. The AWS
provider uses the configured credential chain; this project does not define or
store credentials.

## Configure

Copy `terraform.tfvars.example` to `terraform.tfvars`, then edit the values.
The local tfvars file is ignored by Git.

To create an EC2 instance, set `enable_ec2 = true` and provide an AMI ID valid
for `aws_region`. Optionally set an existing subnet, security groups, or IAM
instance profile. The instance defaults to `t3.micro`, has encrypted gp3 root
storage and requires IMDSv2. It does not get a public IP unless explicitly
enabled. No inbound security-group rules are created.

To create an S3 bucket, set `enable_s3 = true` and provide a globally unique
`s3_bucket_name`. The bucket blocks public access, uses S3-managed encryption,
enforces bucket-owner object ownership, and is not force-deleted. Versioning is
disabled by default and can be enabled with `s3_enable_versioning = true`.

## Review and apply

From this directory, initialize and validate the configuration, then review the
proposed changes before applying:

```shell
terraform init
terraform validate
terraform plan
# Apply only after reviewing the plan:
terraform apply
```

`terraform plan` is a review step and does not create resources. Disable a
service by setting its `enable_*` variable to `false`; review the resulting plan
carefully because it will destroy the corresponding managed resources. Back up
state and verify the plan before any destructive operation.
