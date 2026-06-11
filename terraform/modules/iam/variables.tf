variable "cluster_name" {
  description = "EKS cluster name prefix for IAM resources"
  type        = string
}

variable "tags" {
  description = "Additional tags to attach to IAM resources"
  type        = map(string)
  default     = {}
}
