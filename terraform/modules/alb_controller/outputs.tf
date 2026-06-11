output "oidc_provider_arn" {
  description = "ARN of the created OIDC provider"
  value       = aws_iam_openid_connect_provider.this.arn
}

output "alb_controller_role_arn" {
  description = "IAM role ARN to use for the aws-load-balancer-controller service account"
  value       = aws_iam_role.alb_controller.arn
}

output "alb_controller_role_name" {
  description = "IAM role name"
  value       = aws_iam_role.alb_controller.name
}
