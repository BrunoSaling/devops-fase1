#!/bin/bash
# =============================================================
# user_data.sh — Script de inicialização da instância EC2
# Executado automaticamente no primeiro boot pela AWS
# =============================================================

set -euo pipefail
exec > >(tee /var/log/user-data.log | logger -t user-data) 2>&1

echo "=============================="
echo " Iniciando provisionamento EC2"
echo " $(date)"
echo "=============================="

# Atualizar pacotes do sistema
dnf update -y

# Instalar ferramentas essenciais
dnf install -y \
  git \
  curl \
  wget \
  unzip \
  htop \
  tree

# Instalar Node.js 20 (via NodeSource)
curl -fsSL https://rpm.nodesource.com/setup_20.x | bash -
dnf install -y nodejs

# Verificar versões instaladas
echo "Node.js: $(node --version)"
echo "npm:     $(npm --version)"
echo "Git:     $(git --version)"

# Instalar AWS CLI v2
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip -q awscliv2.zip
./aws/install
rm -rf awscliv2.zip aws/
echo "AWS CLI: $(aws --version)"

# Criar estrutura de diretórios da aplicação
mkdir -p /opt/app/{logs,uploads,config}
chown -R ec2-user:ec2-user /opt/app

# Configurar variáveis de ambiente
cat >> /etc/environment << 'ENV'
NODE_ENV=production
APP_PORT=3000
APP_DIR=/opt/app
ENV

echo "=============================="
echo " Provisionamento concluído!"
echo " $(date)"
echo "=============================="
