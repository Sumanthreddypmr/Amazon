module "vpc" {
  source         = "../../modules/vpc"
  name           = "${var.environment}-amazon-vpc"
  cidr           = var.vpc_cidr
  public_subnets = var.public_subnets
  private_subnets = var.private_subnets
  tags           = merge(var.tags, { Environment = var.environment })
}

module "iam" {
  source       = "../../modules/iam"
  cluster_name = var.cluster_name
  tags         = merge(var.tags, { Environment = var.environment })
}

module "eks" {
  source          = "../../modules/eks"
  cluster_name    = var.cluster_name
  region          = var.region
  vpc_id          = module.vpc.vpc_id
  public_subnets  = module.vpc.public_subnets
  private_subnets = module.vpc.private_subnets
  cluster_role_arn = module.iam.cluster_role_arn
  node_role_arn    = module.iam.node_role_arn
  desired_capacity = var.node_desired_capacity
  min_size         = var.node_min_size
  max_size         = var.node_max_size
  tags             = merge(var.tags, { Environment = var.environment })
}

module "alb_controller" {
  source = "../../modules/alb_controller"
  cluster_name = module.eks.cluster_name
  region = var.region
  service_account_namespace = "kube-system"
  service_account_name = "aws-load-balancer-controller"
}

module "external_dns" {
  source = "../../modules/external_dns"
  cluster_name = module.eks.cluster_name
  region = var.region
  service_account_namespace = "external-dns"
  service_account_name = "external-dns"
}

output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "cluster_ca_data" {
  value = module.eks.cluster_ca_data
}

output "external_dns_role_arn" {
  value = module.external_dns.external_dns_role_arn
}

output "alb_controller_role_arn" {
  value = module.alb_controller.alb_controller_role_arn
}
