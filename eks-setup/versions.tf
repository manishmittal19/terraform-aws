terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.48.0"
    }
  }
}

provider "aws" {
  region     = "us-east-1"
<<<<<<< HEAD
  access_key = "AKIA6ODU3U2MH4SZ46FW"
  secret_key = "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"
=======
  access_key = "AKIAZQ3DS7VKPSJPJ46Y"
  secret_key = "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"
>>>>>>> 2b724defd3d69f17b7d48726bd8e465c5c6836e8
}