provider "aws" {
 region = "eu-north-1"
# access_key = var.aws_access_key
# secret_key = var.aws_secret_key
}

resource "aws_instance" "example" {
  ami = "ami-008dea09a148cea39"
  instance_type = "t3.micro"
  associate_public_ip_address = true
  key_name = "ssh-key"
  vpc_security_group_ids = [aws_security_group.ssh_access.id]
  count = "2"

connection {
  type = "ssh"
  port = "22"
  user = "ubuntu"
  private_key = file("ssh-key")
  timeout = "1m"
  agent = "true"
}

}

resource "aws_key_pair"  "ssh_key"{
  key_name = "ssh-key"
  public_key =  file("ssh-key.pub")
}

resource "aws_security_group" "ssh_access" {
  name = "ssh access for instance"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 8080
    to_port   = 8080
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

egress {
    from_port = 0
    to_port   = 0
    protocol  =  "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

