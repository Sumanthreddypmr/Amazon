environment = "dev"
region = "us-east-1"
cluster_name = "amazon-dev-eks"
vpc_cidr = "10.10.0.0/16"
public_subnets = ["10.10.1.0/24", "10.10.2.0/24"]
private_subnets = ["10.10.11.0/24", "10.10.12.0/24"]
node_desired_capacity = 2
node_min_size = 1
node_max_size = 3
tags = {
  Project     = "Amazon"
  Environment = "dev"
}
