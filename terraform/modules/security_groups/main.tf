# ============================================================
# modules/security_groups/main.tf — Security Groups
# ============================================================

resource "aws_security_group" "app" {
  name        = "${var.nome_projeto}-sg-app-${var.ambiente}"
  description = "SG para a aplicacao"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH (restrito)"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Restringir ao IP do dev em producao
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "${var.nome_projeto}-sg-app-${var.ambiente}" }
}

output "sg_app_id" { value = aws_security_group.app.id }

variable "nome_projeto" {}
variable "ambiente"     {}
variable "vpc_id"       {}
