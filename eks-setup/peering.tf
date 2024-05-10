resource "aws_route" "bastion_to_eks" {
  route_table_id            = module.eks-vpc.private_route_table_ids[0]
  destination_cidr_block    = "10.1.0.0/16"
  vpc_peering_connection_id = ""
}
