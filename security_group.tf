#Criando o grupo de segurança para criar a instancia e liberando o acesso via http e ssh
resource "aws_security_group" "group_security" {
  name = "security-group"
  description = "Security group for instance"
  vpc_id = aws_vpc.vpc_test.id

  ingress {
    description = "Allow HTTP traffic"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH traffic"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1" # "-1" significa todos os protocolos
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "security-group"
  }
}