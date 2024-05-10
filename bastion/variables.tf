variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
  default     = "bastion-vpc"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.1.0.0/16"
}

variable "azs" {
  description = "The availability zones for the VPC"
  type        = list(string)
  default     = ["us-east-1a"]
}

variable "private_subnets" {
  description = "The private subnets for the VPC"
  type        = list(string)
  default     = ["10.1.1.0/24"]
}

variable "public_subnets" {
  description = "The public subnets for the VPC"
  type        = list(string)
  default     = ["10.1.101.0/24"]
}

variable "tags" {
  description = "The tags for the VPC"
  type        = map(string)
  default = {
    Terraform   = "true"
    Environment = "dev"
  }
}
