#!/bin/bash

# Atualiza a lista de pacotes disponíveis
sudo apt update

# Instala pacotes necessários para usar o repositório Docker
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

# Adiciona a chave GPG oficial do Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Adiciona o repositório Docker APT
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Atualiza a lista de pacotes novamente após adicionar o repositório Docker
sudo apt update

# Instala a versão mais recente do Docker CE
sudo apt-get install -y docker-ce

# Inicia o Docker e habilita-o para iniciar na inicialização do sistema
sudo systemctl start docker
sudo systemctl enable docker

# Adiciona o grupo docker e adiciona o usuário atual a este grupo
sudo groupadd docker
sudo usermod -aG docker $USER

# Recarrega os grupos do usuário atual para aplicar a nova associação ao grupo docker
newgrp docker

# Executa um container Apache
docker run -d --name apache-server -p 80:80 -v apache-data:/usr/local/apache2/htdocs httpd

# Espera 60 segundos para garantir que o container do Apache esteja totalmente iniciado
sleep 60 

# Executa um container PostgreSQL
docker run -d -p 5432:5432 -v /tmp/database:/var/lib/postgresql/data -e POSTGRES_PASSWORD=devops123 postgres
