resource "aws_security_group" "app_sg" {
  name        = "${var.app_name}-sg-${substr(md5(timestamp()), 0, 8)}"
  description = "Allow HTTP traffic"
  
  ingress {
    from_port   = 3000
    to_port     = 3000
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

output "security_group_id" {
  value = aws_security_group.app_sg.id
}
