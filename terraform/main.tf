# main.tf

resource "aws_instance" "ubuntu_instance" {
  ami           = "ami-0c55b159cbfafe1f0"  # Ubuntu 20.04 LTS AMI (update to latest AMI as per your region)
  instance_type = "t3.micro"               # Free tier instance type

  # Adding a basic tag to the instance
  tags = {
    Name = "Terraform-Ubuntu"
  }

  # User-data script to install Docker and run NGINX container on EC2
  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install -y docker.io
              systemctl start docker
              systemctl enable docker
              docker run -d -p 80:80 nginx
              EOF
}

# Optional: security group allowing HTTP traffic on port 80
resource "aws_security_group" "allow_http" {
  name_prefix = "allow_http_"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
