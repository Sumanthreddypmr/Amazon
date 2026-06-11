resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  role_arn = var.cluster_role_arn
  version  = "1.30"

  vpc_config {
    subnet_ids = concat(var.public_subnets, var.private_subnets)
    endpoint_public_access = true
    endpoint_private_access = true
    public_access_cidrs = ["0.0.0.0/0"]
  }

  tags = merge({
    Name = var.cluster_name,
  }, var.tags)
}

resource "aws_eks_node_group" "this" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "${var.cluster_name}-nodegroup"
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.private_subnets

  scaling_config {
    desired_size = var.desired_capacity
    min_size     = var.min_size
    max_size     = var.max_size
  }

  instance_types = ["t3.medium"]
  capacity_type  = "ON_DEMAND"

  tags = merge({
    Name = "${var.cluster_name}-nodegroup",
  }, var.tags)
}
