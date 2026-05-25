# ============================================================
# modules/ec2/main.tf — Módulo EC2
# ============================================================

resource "aws_instance" "app" {
  ami                    = var.ami_id
  instance_type          = var.tipo_instancia
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.sg_ids
  key_name               = var.chave_ssh
  user_data              = var.user_data

  root_block_device {
    volume_type           = "gp3"
    volume_size           = 20
    delete_on_termination = true
  }

  tags = { Name = "${var.nome_projeto}-ec2-app-${var.ambiente}" }
}

output "ip_publico" { value = aws_instance.app.public_ip }
output "instance_id" { value = aws_instance.app.id }

variable "nome_projeto" {}
variable "ambiente" {}
variable "ami_id" {}
variable "tipo_instancia" {}
variable "subnet_id" {}
variable "sg_ids" {}
variable "chave_ssh" {}
variable "user_data" {}
