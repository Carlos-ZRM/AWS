
locals {
  region = "us-east-1"
  s3_user = "user-s3-dev"
  s3_name = "private_bucket.s3.dev"
  profile = "default"

  # Common tags to be assigned to all resources
  tags = {
    Platform = "devs"
  }
}
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = local.region
  profile = local.profile
}


resource "aws_iam_user" "s3_user" {
  name = local.s3_user
  path = "/"
  tags = local.tags
}

resource "aws_iam_access_key" "s3_user" {
  user = aws_iam_user.s3_user.name
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = local.s3_name
  acl    = "private"
  tags = local.tags
}


resource "aws_s3_bucket_policy" "s3_policy" {
  bucket = aws_s3_bucket.s3_bucket.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression's result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "BUCKETPOLICY"
    Statement = [
      {
        Sid       = "UserAllow"
        Effect    = "Allow"
        Principal = {
            "AWS" = aws_iam_user.s3_user.arn, 
        }
        Action    = "s3:*"
        Resource = [
          aws_s3_bucket.s3_bucket.arn,
          "${aws_s3_bucket.s3_bucket.arn}/*",
        ]
      },
    ]
  })
}