# This needs the DNS NAme of your ALB 

resource "aws_route53_record" "record" {
  zone_id = "Z09626353E72G6GNQ0R5A"
  name    = "${var.COMPONENT}-dev.roboshop.internal"
  type    = "A"
  ttl     = 60
  records = [aws_spot_instance_request.cheap_worker.private_ip]
}