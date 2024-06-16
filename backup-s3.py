import os
import subprocess
import boto3
from datetime import datetime

# Configurações do banco de dados PostgreSQL
db_host = 'localhost'
db_port = '5432'
db_name = 'testdb'
db_user = 'postgres'
db_password = '123456'

# Configurações do Amazon S3
s3_bucket_name = 'devops-s3'
s3_backup_path = 'backup'

# Diretório temporário para armazenar o backup localmente
temp_dir = '/tmp'

def create_pg_dump_backup():
    # Criando o nome do arquivo de backup utilizando a data/hora
    filename = f'{db_name}_backup_{datetime.now().strftime("%Y-%m-%d_%H-%M-%S")}.sql'

    # Comando para gerar o arquivo de backup usando pg_dump
    command = f'pg_dump -h {db_host} -p {db_port} -U {db_user} -Fc {db_name} > {os.path.join(temp_dir, filename)}'

    try:
        subprocess.run(command, shell=True, check=True)
        print(f'Backup do banco de dados {db_name} criado em {filename}')
        return filename
    except subprocess.CalledProcessError as e:
        print(f'Erro ao gerar o backup: {e}')
        return None

def upload_to_s3(filename):
    # Configurando o cliente S3 com suas credenciais
    aws_access_key_id = "aws_access_key_id"
    aws_secret_access_key = "aws_secret_access_key"
    s3_client = boto3.client('s3', aws_access_key_id=aws_access_key_id, aws_secret_access_key=aws_secret_access_key)

    # Caminho completo no S3 onde o arquivo será armazenado
    s3_backup_key = os.path.join(s3_backup_path, filename)

    # Caminho completo do arquivo local
    local_backup_file = os.path.join(temp_dir, filename)

    try:
        # Upload do arquivo para o S3
        s3_client.upload_file(local_backup_file, s3_bucket_name, s3_backup_key)
        print(f'Backup {filename} enviado com sucesso para o S3 bucket {s3_bucket_name}')
        return True
    except Exception as e:
        print(f'Erro ao enviar o backup para o S3: {e}')
        return False
    finally:
        # Deletando arquivo temporário local após o upload
        if os.path.exists(local_backup_file):
            os.remove(local_backup_file)
            print(f'Arquivo temporário {filename} deletado')

def main():
    # Criar backup usando pg_dump
    backup_filename = create_pg_dump_backup()
    
    if backup_filename:
        # Enviar backup para o S3
        upload_to_s3(backup_filename)

if __name__ == "__main__":
    main()
