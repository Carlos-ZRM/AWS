#Each Terraform module must declare which providers it requires,
#so that Terraform can install and use them. 
#Provider requirements are declared in a required_providers block.

#A provider requirement consists of a local name, a source location, and a version constraint:

locals {
  region = "us-east-1"
  s3_user = "user-s3-dev"
  s3_name = "domain.s3.dev"
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

data "aws_iam_user" "example" {
  user_name = "guest"
}

output "user_info" {
  value = data.aws_iam_user.example
}

data "aws_iam_group" "example" {
  group_name= "admins"
}

output "group_info" {
  value = data.aws_iam_group.example
}


resource "aws_iam_user" "s3_user" {
  # Variable nombre de usuario
  name = local.s3_user
  path = "/"
  tags = local.tags
}

resource "aws_iam_access_key" "s3_user" {
  user = aws_iam_user.s3_user.name
}


resource "aws_s3_bucket" "s3_bucket" {
  # variable bucket name
  bucket = local.s3_name
  acl    = "public-read"
  tags = local.tags
  
  website {
    index_document = "index.html"
    error_document = "error.html"
  }
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
        Sid       = "PublicAllow"
        Effect    = "Allow"
        Principal = {
            "AWS" = aws_iam_user.s3_user.arn, 
        }
        Action    = "s3:GetObject"
        Resource = [
          aws_s3_bucket.s3_bucket.arn,
          "${aws_s3_bucket.s3_bucket.arn}/*",
        ]
      },
    ]
  })
}