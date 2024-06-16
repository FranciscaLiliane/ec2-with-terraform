#Criação da vpc e suas subnets
resource "aws_vpc" "vpc_test" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
}

resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.vpc_test.id
  cidr_block = "10.0.1.0/24"
}

resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.vpc_test.id
  cidr_block = "10.0.2.0/24"
}

output "vpc_id" {
  value = aws_vpc.vpc_test.id
}