provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "one" {
  ami = "ami-05bfbece1ed5beb54"
  instance_type = "t2.micro"
  key_name = "Jenkins"
  vpc_security_group_ids = aws_security_group.third.id
  availability_zone = "us-east-1a"
  user_data =<<EOF
#!/bin/bash
  sudo -i
  yum install httpd -y
  systemctl start httpd 
  chkconfig httpd on
  echo " hai this is server-1" > /var/www/html/index.html
  EOF
  tags = {
    Name = "server-1"
  }
}

resource "aws_instance" "two" {
  ami = "ami-05bfbece1ed5beb54"
  instance_type = "t2.micro"
  key_name = "Jenkins"
  availability_zone = "us-east-1b"
  vpc_security_group_ids = aws_security_group.third.id
  user_data =<<EOF
#!/bin/bash
  sudo -i
  yum install httpd -y
  systemctl start httpd
  chkconffig httpd on
  echo "hai this is server-2" > /var/www/html/index.html
  EOF
  tags = {
    Name = "server-2"
  }
} 

resource "aws_security_group" "third" {
  name = "eib_sg"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


    
  
