# This needs the DNS NAme of your ALB 

resource "aws_route53_record" "record" {
  zone_id = data.terraform_remote_state.vpc.outputs.HOSTEDZONE_PRIVATE_ID
  name    = "${var.COMPONENT}-${var.ENV}.${data.terraform_remote_state.vpc.outputs.HOSTEDZONE_PRIVATE_ZONE}"
  type    = "CNAME"
  ttl     = 60
  records = var.LB_TYPE == "internal" ? [data.terraform_remote_state.alb.outputs.PRIVATE_ALB_ADDRESS] : [data.terraform_remote_state.alb.outputs.PUBLIC_ALB_ADDRESS]
records = var.LB_TYPE == "internal" ? [data.terraform_remote_state.alb.outputs.PRIVATE_ALB_ADDRESS] : [data.terraform_remote_state.alb.outputs.PUBLIC_ALB_ADDRESS]
 #records   = [data.terraform_remote_state.alb.outputs.PRIVATE_ALB_ADDRESS]
}



### Now frontend has to be attached to the Public Loadbalancer and have the DNS Created in the public hosted zone 
### Now backend has to be attached to the Private Loadbalancer and have the DNS Created in the private hosted zone 