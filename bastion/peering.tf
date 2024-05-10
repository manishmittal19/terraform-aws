data "aws_caller_identity" "this" {}

resource "aws_vpc_peering_connection" "bastion_to_eks" {
  vpc_id        = module.bastion-vpc.vpc_id # bastion-vpc --> eks-vpc
  peer_vpc_id   = "vpc-060480462c809bd3f"   # eks-vpc
  peer_owner_id = data.aws_caller_identity.this.account_id
  peer_region   = "us-east-1"
  tags = {
    Name = "bastion-to-eks"
  }
}

resource "aws_vpc_peering_connection_accepter" "bastion_to_eks" {
  vpc_peering_connection_id = aws_vpc_peering_connection.bastion_to_eks.id
  auto_accept               = true
  tags = {
    "Name" = "bastion-to-eks"
  }
}

resource "aws_route" "bastion_to_eks" {
  route_table_id            = module.bastion-vpc.public_route_table_ids[0]
  destination_cidr_block    = "10.2.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.bastion_to_eks.id
}