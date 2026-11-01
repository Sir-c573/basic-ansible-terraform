terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>6.0"
    }
  }

}

provider "aws" {
  region = "us-east-1"
}
#created a security_group
resource "aws_security_group" "web_sg" {
  name        = "ansible_web_sg"
  description = "Allow ssh and HTTP traffic"



  ingress {
    description = "SSH from my IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_cidr]
  }

  ingress {
    description = "HTTP from everywhere"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "ansible-web-sg"
  }

}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] #published by ubuntu

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"] #ubuntuOS 24.04 version amd64 everyting it can follow
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"] #only hvm virtalization 
  }

}

resource "aws_instance" "web" {

  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  associate_public_ip_address = true


  tags = {
    Name = "Ansbile-web-server"
  }
}