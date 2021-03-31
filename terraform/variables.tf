
locals {
  region = "us-east-1"
  s3_user = "s3_authorize_dev"
  s3_name = "carlos.zreyesmtz.com"
  profile = "default"
  # Common tags to be assigned to all resources
  tags = {
    Platform = "common"
  }
}
