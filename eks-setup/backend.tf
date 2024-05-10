<<<<<<< HEAD
terraform {
  backend "s3" {
    bucket         = "terraform-state-sruhy9"
    key            = "eks/terraform.tfstate"
    dynamodb_table = "terraform-lock"
    encrypt        = true
    region         = "us-east-1"
    access_key     = "AKIA6ODU3U2MH4SZ46FW"
    secret_key     = "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"
  }
}
=======
# terraform {
#   backend "s3" {
#     bucket         = "terraform-state-numelv"
#     key            = "eks/terraform.tfstate"
#     dynamodb_table = "terraform-lock"
#     encrypt        = true
#     region         = "us-east-1"
#     access_key     = "AKIAZQ3DS7VKPSJPJ46Y"
#     secret_key     = "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"
#   }
# }
>>>>>>> 2b724defd3d69f17b7d48726bd8e465c5c6836e8
