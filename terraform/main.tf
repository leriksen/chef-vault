terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~>4.0"
    }
  }

  backend "local" {
    path = "tf.state"
  }
}

provider "aws" {
  region = "ap-southeast-2"
}

resource "aws_vpc" "vault" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "vault"
  }
}

resource "aws_internet_gateway" "vault" {
  vpc_id = aws_vpc.vault.id

  tags = {
    Name = "vault"
  }
}

resource "aws_subnet" "vault" {
  vpc_id     = aws_vpc.vault.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "vault"
  }
}

resource "aws_route_table" "vault" {
  vpc_id = aws_vpc.vault.id

  tags = {
    Name = "vault"
  }
}


resource "aws_route_table_association" "vault" {
  subnet_id      = aws_subnet.vault.id
  route_table_id = aws_route_table.vault.id
}

resource "aws_route" "gateway" {
  route_table_id         = aws_route_table.vault.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.vault.id
}

resource "aws_network_acl" "vault" {
  vpc_id = aws_vpc.vault.id
  tags = {
    Name = "vault"
  }
}

resource "aws_network_acl_association" "vault" {
  network_acl_id = aws_network_acl.vault.id
  subnet_id      = aws_subnet.vault.id
}

resource "aws_network_acl_rule" "ssh" {
  network_acl_id = aws_network_acl.vault.id
  rule_number    = 100
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = aws_vpc.vault.cidr_block
  from_port      = 22
  to_port        = 22
}

resource "aws_network_acl_rule" "responses" {
  network_acl_id = aws_network_acl.vault.id
  rule_number    = 200
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = aws_vpc.vault.cidr_block
  from_port      = 32768
  to_port        = 65535
}

resource "aws_network_acl_rule" "outbound" {
  network_acl_id = aws_network_acl.vault.id
  rule_number    = 100
  egress         = true
  protocol       = "all"
  rule_action    = "allow"
  cidr_block     = aws_vpc.vault.cidr_block
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.vault.id

  ingress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["49.185.176.143/32"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}

resource "local_file" "generate_vagrantfile" {
  content = templatefile("${path.module}/Vagrantfile.tftpl", {
    security_group = aws_security_group.allow_ssh.id,
    subnet         = aws_subnet.vault.id
  })
  filename = "Vagrantfile"
}