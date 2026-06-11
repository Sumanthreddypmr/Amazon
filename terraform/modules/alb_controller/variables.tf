variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "service_account_namespace" {
  description = "Kubernetes namespace where the controller service account will live"
  type        = string
  default     = "kube-system"
}

variable "service_account_name" {
  description = "Kubernetes service account name for the controller"
  type        = string
  default     = "aws-load-balancer-controller"
}
