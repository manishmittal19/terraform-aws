variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
  default     = "eks-vpc"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.2.0.0/16"
}

variable "azs" {
  description = "The availability zones for the VPC"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "private_subnets" {
  description = "The private subnets for the VPC"
  type        = list(string)
  default     = ["10.2.1.0/24", "10.2.2.0/24", "10.2.3.0/24"]
}

variable "public_subnets" {
  description = "The public subnets for the VPC"
  type        = list(string)
  default     = ["10.2.101.0/24"]
}

variable "tags" {
  description = "The tags for the VPC"
  type        = map(string)
  default = {
    Terraform   = "true"
    Environment = "dev"
  }
}

variable "eks_cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
  default     = "eks-demo"
}

variable "eks_cluster_version" {
  description = "The version of the EKS cluster"
  type        = string
  default     = "1.29"
}