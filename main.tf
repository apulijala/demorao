provider "aws" {
  region = "eu-west-2"
}

resource "aws_security_group" "mysec" {
  name        = var.secgrouname
  description = "Allow 8080 and 22 inbound traffic"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
   ingress {
        from_port   = 8080
        to_port     = 8080
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    
  }
  
}


resource "aws_instance" "web" {
  ami           = var.ami
  instance_type = "t2.micro"
  key_name = var.keyname
  vpc_security_group_ids = [aws_security_group.mysec.id]

  tags = {
    Name = var.instancename
  }
}