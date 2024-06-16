#variáveis para o ec2
variable "name" {
  description = "Application Name"
  default = "devops_app"
}

variable "env" {
  description = "Environment of the application"
  default = "dev"
}

variable "instance_type" {
  description = "AWS instance type"
  default = "t2.micro"
}

variable "ami" {
  description = "AWS AMI"
  default = "ami-0b0ea68c435eb488d"
}

variable "repository" {
  description = "Aplication repository"
  default = "https://github.com/FranciscaLiliane/testDevops"
}

