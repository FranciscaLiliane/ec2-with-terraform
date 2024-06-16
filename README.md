# Projeto Terraform e Docker

Este repositório contém scripts e configurações para gerenciar a infraestrutura na AWS usando Terraform e para gerenciar containers Docker. Inclui um exemplo de integração contínua usando Jenkins.

## Estrutura do Projeto

- **Dockerfile**: Arquivo de definição para construir uma imagem Docker personalizada.
- **README.md**: Este arquivo de documentação.
- **backup-s3.py**: Script Python para fazer backup de dados para o S3.
- **createEc2.tf**: Configuração Terraform para criar instâncias EC2.
- **jenkins_deploy.xml**: Script xml para Jenkins buscar um arquivo no S3 e publicar em um container Docker.
- **helloWorld.php**: Arquivo PHP de exemplo.
- **main.tf**: Arquivo principal do Terraform que configura o provedor AWS.
- **requirements.sh**: Script para instalar dependências necessárias (como o Docker).
- **security_group.tf**: Configuração Terraform para criar grupos de segurança.
- **variables.tf**: Definições de variáveis para o Terraform.
- **vpc.tf**: Configuração Terraform para criar uma VPC.

## Requisitos

- Terraform v1.0 ou superior
- AWS CLI configurado com suas credenciais
- Docker
- Python 3.x

## Passos para Configuração

### 1. Inicializar o Terraform

No diretório do projeto, execute:

```sh
terraform init

terraform plan

terraform apply
```
Devops Analist: Liliane Silva
