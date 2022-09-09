resource "aws_lb_target_group" "app" {
  name     = "${var.COMPONENT}-${var.ENV}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}