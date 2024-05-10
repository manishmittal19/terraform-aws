# Create the Bastion VPC

module "eks-vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name                    = var.vpc_name
  cidr                    = var.vpc_cidr
  enable_nat_gateway      = true
  single_nat_gateway = true
  azs                     = var.azs
  private_subnets         = var.private_subnets
  public_subnets          = var.public_subnets
  map_public_ip_on_launch = true
  tags                    = var.tags

  public_subnet_tags = {
    "kubernetes.io/cluster/${var.eks_cluster_name}" = "shared"
    "kubernetes.io/role/elb"                          = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${var.eks_cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"                 = "1"
  }
}

resource "aws_security_group_rule" "allow_access_k8s_api" {
  type      = "ingress"
  from_port = 443
  to_port   = 443
  protocol  = "tcp"
  // Allows 443 access only form bastion VPC cidr
  cidr_blocks       = ["10.1.0.0/16"]
  security_group_id = module.eks.cluster_security_group_id
}

resource "aws_security_group_rule" "allow_ssh_from_bastion_vpc" {
  type      = "ingress"
  from_port = 22
  to_port   = 22
  protocol  = "tcp"
  // Allows SSH only form bastion VPC cidr
  cidr_blocks       = ["10.1.0.0/16"]
  security_group_id = module.eks-vpc.default_security_group_id
}

# resource "aws_security_group_rule" "allow_egress" {
#   type              = "egress"
#   from_port         = 0
#   to_port           = 0
#   protocol          = "-1"
#   cidr_blocks       = ["0.0.0.0/0"]
#   security_group_id = module.eks-vpc.default_security_group_id
# }
resource "aws_instance" "server" {
  ami                    = "ami-04ff98ccbfa41c9ad"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [module.eks-vpc.default_security_group_id]
  subnet_id              = module.eks-vpc.private_subnets[0]
}