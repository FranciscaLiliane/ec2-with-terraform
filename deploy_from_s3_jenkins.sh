#!/bin/bash

# Definindo variáveis
BUCKET_NAME="devops-s3"
FILE_KEY="hello-world.php"
LOCAL_PATH="./hello-world.php"
CONTAINER_NAME="apache-server"
CONTAINER_PATH="/var/www/html/"

# Buscando arquivo PHP dentro do S3
echo "Baixando o arquivo do S3..."
aws s3 cp s3://$BUCKET_NAME/$FILE_KEY $LOCAL_PATH

if [ $? -ne 0 ]; then
  echo "Erro ao baixar o arquivo do S3"
  exit 1
fi

# Copiando o arquivo para dentro do container
echo "Copiando o arquivo para o container Docker..."
docker cp $LOCAL_PATH $CONTAINER_NAME:$CONTAINER_PATH

if [ $? -ne 0 ]; then
  echo "Erro ao copiar o arquivo para o container Docker"
  exit 1
fi

# Reiniciando o container
echo "Reiniciando o container Docker..."
docker restart $CONTAINER_NAME

if [ $? -ne 0 ]; then
  echo "Erro ao reiniciar o container Docker"
  exit 1
fi

echo "Arquivo implantado e container reiniciado com sucesso."
