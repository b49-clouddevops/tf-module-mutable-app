# This needs the DNS NAme of your ALB 

resource "aws_route53_record" "record" {
  zone_id = data.terraform_remote_state.vpc.outputs.HOSTEDZONE_PRIVATE_ID
  name    = "${var.COMPONENT}-${var.ENV}.${data.terraform_remote_state.vpc.outputs.HOSTEDZONE_PRIVATE_ZONE}"
  type    = "A"
  ttl     = 60
  records = [data.terraform_remote_state.alb.outputs.PRIVATE_ALB_ADDRESS]
}