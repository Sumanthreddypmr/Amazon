variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "service_account_namespace" {
  description = "Kubernetes service account namespace"
  type        = string
  default     = "external-dns"
}

variable "service_account_name" {
  description = "Kubernetes service account name"
  type        = string
  default     = "external-dns"
}
