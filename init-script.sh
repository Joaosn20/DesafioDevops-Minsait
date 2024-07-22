#!/bin/bash

# Atualiza o sistema e instala pacotes necessários
apt-get update
apt-get upgrade -y
apt-get install -y apt-transport-https ca-certificates curl software-properties-common

# Instala o Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update
apt-get install -y docker-ce

# Instala o Docker Compose
curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Cria o arquivo docker-compose.yml
cat <<EOT > /home/${username}/docker-compose.yml
${docker_compose_content}
EOT

# Inicia o Docker Compose
cd /home/${username}
docker-compose up -d
