resource "aws_security_group" "web_sg" {

  name   = "web-security-group"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
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
    Name = "web-security-group"
  }
}

resource "aws_instance" "web_server" {

  ami                         = var.ami
  instance_type               = var.instance_type

  subnet_id                   = var.subnet_id

  vpc_security_group_ids      = [aws_security_group.web_sg.id]

  associate_public_ip_address = true

  key_name = var.key_name

  tags = {
    Name = "terraform-web-server"
  }
}
