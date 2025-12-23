terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.69"
    }
  }
  required_version = "~> 1.9"
}

resource "aws_security_group" "terraf_sg" {
  name        = "terraf_sg"
  description = "Security group for Terraform EC2 instance"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
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
    Name = "terraf_sg"
  }
}

resource "aws_instance" "terraf_ec2" {
  ami                    = "ami-068c0051b15cdb816"
  instance_type          = var.instance_type
  key_name               = var.par_key
  vpc_security_group_ids = [aws_security_group.terraf_sg.id]

  tags = {
    Name = "terraf_ec2"
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y httpd
              sudo systemctl start httpd
              sudo systemctl enable httpd
              echo "<h1>Deployed via Terraform $(hostname -f)</h1>" > /var/www/html/index.html
              EOF
}
