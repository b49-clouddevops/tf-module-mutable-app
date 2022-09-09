# Creates TG 
resource "aws_lb_target_group" "app" {
  name     = "${var.COMPONENT}-${var.ENV}"
  port     = 8080
  protocol = "HTTP"
  vpc_id   =data.terraform_remote_state.vpc.outputs.VPC_ID 
}

# Now attachi instances to the created target.
resource "aws_lb_target_group_attachment" "instance-attach" {
  target_group_arn = aws_lb_target_group.app.arn
  target_id        = local.ALL_INSTANCE_IDS
  port             = 80
}