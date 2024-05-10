# Create the Bastion VPC

module "bastion-vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name                    = var.vpc_name
  cidr                    = var.vpc_cidr
  azs                     = var.azs
  private_subnets         = var.private_subnets
  public_subnets          = var.public_subnets
  map_public_ip_on_launch = true
  tags                    = var.tags
}

resource "aws_security_group_rule" "bastion_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.bastion-vpc.default_security_group_id
}

resource "aws_security_group_rule" "default_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.bastion-vpc.default_security_group_id
}

resource "aws_instance" "server" {
  ami                    = "ami-04ff98ccbfa41c9ad"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [module.bastion-vpc.default_security_group_id]
  subnet_id              = module.bastion-vpc.public_subnets[0]
  key_name               = aws_key_pair.bastion_key.key_name
}

resource "aws_key_pair" "bastion_key" {
  key_name   = "bastion_key"
  public_key = file("~/.ssh/id_rsa.pub")
}