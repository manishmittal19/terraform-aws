terraform {
  backend "s3" {
    bucket         = "terraform-state-sruhy9"
    key            = "eks/terraform.tfstate"
    dynamodb_table = "terraform-lock"
    encrypt        = true
    region         = "us-east-1"
    access_key     = ""
    secret_key     = ""
  }
}