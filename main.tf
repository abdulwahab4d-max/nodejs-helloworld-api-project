# Create or import your SSH key pair
resource "aws_key_pair" "mykey" {
  key_name   = "mykey"
  public_key = file("mykey.pub")   # Ensure mykey.pub is in the same folder
}

# Security group for HTTP + SSH
resource "aws_security_group" "allow_http" {
  name_prefix = "allow_http_"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

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
}

resource "aws_instance" "ubuntu" {
  ami           = "ami-0fa91bc90632c73c9"
  instance_type = "t3.micro"

  # 🟢 Add the SSH key here
  key_name = aws_key_pair.mykey.key_name

  # Attach the security group
  vpc_security_group_ids = [aws_security_group.allow_http.id]

  tags = {
    Name = "Terraform-Ubuntu-nodejs"
  }

  user_data = <<-EOF
    #!/bin/bash
    apt update -y
    apt install -y docker.io
    
    # Enable docker
    systemctl start docker
    systemctl enable docker
    
    sudo apt install npm
    sudo npm install body-parser
    sudo npm install cors
    sudo npm install express
    
  EOF
}
