# variable platform
# variable user name
# variable bucket name

resource "aws_iam_user" "s3_user" {
  # Variable nombre de usuario
  name = "loadbalancer"
  path = "/"

  tags = {
    # variable platform
    Platform = ""
  }
}

resource "aws_iam_access_key" "s3_user" {
  user = aws_iam_user.s3_user.name
}

resource "aws_s3_bucket" "s3_bucket" {
  # variable bucket name
  bucket = "bucket_name"
  acl    = "private"
  tags = {
    # variable platform
    Platform = ""
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
