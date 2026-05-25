# ============================================================
# outputs.tf — Saídas do Terraform
# ============================================================

output "vpc_id" {
  description = "ID da VPC criada"
  value       = module.vpc.vpc_id
}

output "subnets_publicas" {
  description = "IDs das subnets públicas"
  value       = module.vpc.subnet_publica_ids
}

output "subnets_privadas" {
  description = "IDs das subnets privadas"
  value       = module.vpc.subnet_privada_ids
}

output "ec2_ip_publico" {
  description = "IP público da instância EC2 da aplicação"
  value       = module.ec2_app.ip_publico
}

output "ec2_id" {
  description = "ID da instância EC2"
  value       = module.ec2_app.instance_id
}

output "s3_bucket_artefatos" {
  description = "Nome do bucket S3 para artefatos de build"
  value       = module.s3_artefatos.bucket_name
}

output "s3_bucket_arn" {
  description = "ARN do bucket S3"
  value       = module.s3_artefatos.bucket_arn
}
