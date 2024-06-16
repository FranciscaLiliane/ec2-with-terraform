import os
import subprocess
import boto3
from datetime import datetime

db_host = 'localhost'
db_port = '5432'
db_name = 'testdb'
db_user = 'postgres'
db_password = '123456'

s3_bucket_name = 'devops-s3'
s3_backup_path = 'backup'

temp_dir = '/tmp'

#Criando o nome do arquivo de backup utilizando a data/hora
filename = f'{db_name}_backup_{datetime.now().strftime("%Y-%m-%d_%H-%M-%S")}.sql'

#gerando o arquivo de backup
command = f'pg_dump --version "12.15" -h {db_host} -p {db_port} -U {db_user} -Fc {db_name} > {os.path.join(temp_dir, filename)}'

try:
    subprocess.run(command, shell=True, check=True)
except subprocess.CalledProcessError as e:
    print(f'Erro ao gerar o backup: {e}')
    exit(1)

#Configurando  s3
s3_client = boto3.client('s3', aws_access_key_id="aws_access_key_id", aws_secret_access_key="aws_secret_access_key")
s3_backup_path = os.path.join(s3_backup_path, filename)
s3_client.upload_file(os.path.join(temp_dir, filename), s3_bucket_name, s3_backup_path)

#deletando arquivo temporario
os.remove(os.path.join(temp_dir, filename))

print(f'Backup Criado! Arquivo {filename} armazenado no s3')