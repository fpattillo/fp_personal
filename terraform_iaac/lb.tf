resource "aws_lb" "arquichat-lb" {
  name               = "arquichat-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.arquichat-sg.id]
  subnets            = [aws_subnet.arquichat-sn1.id, aws_subnet.arquichat-sn2.id, aws_subnet.arquichat-sn3.id]

  enable_deletion_protection = false

  tags = {
  }
}