variable "environment" {
  description = "Deployment environment name"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnets" {
  description = "Public subnet CIDRs"
  type        = list(string)
}

variable "private_subnets" {
  description = "Private subnet CIDRs"
  type        = list(string)
}

variable "node_desired_capacity" {
  description = "Desired EKS worker capacity"
  type        = number
}

variable "node_min_size" {
  description = "Minimum EKS worker nodes"
  type        = number
}

variable "node_max_size" {
  description = "Maximum EKS worker nodes"
  type        = number
}

variable "tags" {
  description = "Common tags for resources"
  type        = map(string)
  default     = {}
}
