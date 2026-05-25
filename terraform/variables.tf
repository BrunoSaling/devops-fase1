# ============================================================
# variables.tf — Variáveis do Projeto
# ============================================================

variable "aws_region" {
  description = "Região AWS onde os recursos serão criados"
  type        = string
  default     = "us-east-1"
}

variable "nome_projeto" {
  description = "Nome do projeto (usado como prefixo nos recursos)"
  type        = string
  default     = "devops-fase1"
}

variable "ambiente" {
  description = "Ambiente de implantação"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.ambiente)
    error_message = "O ambiente deve ser: dev, staging ou prod."
  }
}

variable "turma" {
  description = "Identificador da turma (para tagging)"
  type        = string
  default     = "DevOps-2024"
}

variable "cidr_vpc" {
  description = "Bloco CIDR da VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnets_publicas" {
  description = "CIDRs das subnets públicas"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "subnets_privadas" {
  description = "CIDRs das subnets privadas"
  type        = list(string)
  default     = ["10.0.10.0/24", "10.0.11.0/24"]
}

variable "tipo_instancia" {
  description = "Tipo da instância EC2"
  type        = string
  default     = "t2.micro" # Free tier elegível no AWS Academy
}

variable "chave_ssh" {
  description = "Nome do Key Pair para acesso SSH às instâncias EC2"
  type        = string
  default     = "devops-key"
}
