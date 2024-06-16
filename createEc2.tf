#Criação da instancia ec2
#Definindo uma chave ssh vinculada a instancia
resource "aws_key_pair" "sshkey" {
  key_name   = "devops_ssh"
  public_key = file("./id_rsa.pub")
}

#ESSE BLOCO É RESPONSÁVEL PELA CRIAÇÃO DA INSTÂNCIA
resource "aws_instance" "server" {
  ami = var.ami           
  instance_type = var.instance_type //Foi escolhida uma instância do tipo t2.micro
  associate_public_ip_address = true
  subnet_id = aws_subnet.public_subnet.id
  key_name = aws_key_pair.sshkey.key_name
  user_data = file("./requirements.sh") //Nesse trecho de código eu chamo o arquivo que contem os comandos de instalação do docker dentro da minha instância

  tags = {
    Name = var.name
    Environment = var.env
    Provisioner = "Terraform"
    repo = var.repository
  }
}