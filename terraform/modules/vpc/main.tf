# ============================================================
# modules/vpc/main.tf — Módulo de Rede (VPC)
# ============================================================

resource "aws_vpc" "main" {
  cidr_block           = var.cidr_vpc
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = { Name = "${var.nome_projeto}-vpc-${var.ambiente}" }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags   = { Name = "${var.nome_projeto}-igw-${var.ambiente}" }
}

# Subnets Públicas
resource "aws_subnet" "publicas" {
  count                   = length(var.subnets_publicas)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnets_publicas[count.index]
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = true

  tags = { Name = "${var.nome_projeto}-subnet-publica-${count.index + 1}-${var.ambiente}" }
}

# Subnets Privadas
resource "aws_subnet" "privadas" {
  count             = length(var.subnets_privadas)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnets_privadas[count.index]
  availability_zone = var.azs[count.index]

  tags = { Name = "${var.nome_projeto}-subnet-privada-${count.index + 1}-${var.ambiente}" }
}

# Route Table Pública
resource "aws_route_table" "publica" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = { Name = "${var.nome_projeto}-rt-publica-${var.ambiente}" }
}

resource "aws_route_table_association" "publica" {
  count          = length(aws_subnet.publicas)
  subnet_id      = aws_subnet.publicas[count.index].id
  route_table_id = aws_route_table.publica.id
}

# Outputs do módulo
output "vpc_id" { value = aws_vpc.main.id }
output "subnet_publica_ids" { value = aws_subnet.publicas[*].id }
output "subnet_privada_ids" { value = aws_subnet.privadas[*].id }

variable "nome_projeto" {}
variable "ambiente" {}
variable "cidr_vpc" {}
variable "azs" {}
variable "subnets_publicas" {}
variable "subnets_privadas" {}
