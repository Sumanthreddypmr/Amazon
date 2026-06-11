output "external_dns_role_arn" {
  description = "IAM role ARN for external-dns service account"
  value       = aws_iam_role.external_dns.arn
}
