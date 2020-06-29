# my first program
/*
resource key pair
*/
resource "aws_key_pair" "deployer_balaji" {
  key_name   = "deployer-key"
}
/*
  create Provider
*/

provider "aws" {

  region     = "ap-south-1"

  access_key = "my-access-key"

  secret_key = "my-secret-key"

}
/*
  create security group
*/

resource "aws_security_group" "myfirst-sg" {
  name        = "myfirst-mnp-sg"
  description = "inbound and outbound  traffic"
  #vpc_id      = "${aws_vpc.main.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "myfirst-mnp-sg"
  }
}

/*

AWS Instance
*/

resource "aws_instance" "ec2-myfirst-terraform-ins" {
  ami           = "ami-052c08d70def0ac62"
  vpc_security_group_ids = [aws_security_group.myfirst-sg.id]
  instance_type = "t2.micro"

  tags = {
    Name = "ec2-myfirst-terraform"
    }
  }