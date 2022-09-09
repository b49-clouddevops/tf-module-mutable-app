# Request a spot instance
resource "aws_spot_instance_request" "spot" {
  count                   = var.SPOT_INSTANCE_COUNT  # whenever you use count, you need to use element to pick form the list.
  ami                     = data.aws_ami.ami.id
  instance_type           = var.INSTANCE_TYPE
  wait_for_fulfillment    = true 
  vpc_security_group_ids  = [aws_security_group.allow_app.id]
  subnet_id               = element(data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS, count.index)
  tags = {
    Name = "${var.COMPONENT}-${var.ENV}"
  }
}

# Creates On Demand Instance
resource "aws_instance" "od" {
  count                   = var.OD_INSTANCE_COUNT
  ami                     = data.aws_ami.ami.id
  instance_type           =  var.INSTANCE_TYPE
  vpc_security_group_ids  = [aws_security_group.allow_app.id]
  subnet_id               = element(data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS, count.index)

  tags = {
    Name = "${var.COMPONENT}-${var.ENV}"
  }
}


# Locals helps you in reducing the code repetitiveness
locals {
    ALL_INSTANCE_IDS = concat(aws_instance.od.*.id, aws_spot_instance_request.spot.*.spot_instance_id)
}

# Creating tags for the spot instance, if not only request tags will be created.

resource "aws_ec2_tag" "name-tag" {
  count       = var.SPOT_INSTANCE_COUNT + var.OD_INSTANCE_COUNT
  resource_id = element(local.ALL_INSTANCE_IDS)
  key         = "Name"
  value       = "${var.COMPONENT}-${var.ENV}"
}



# resource "null_resource" "null" {
#   triggers = {    
#         a = timestamp()  # Everytime you run, when compared to the last time, the time changes, so it will be triggered all the time.
#   }
#   provisioner "remote-exec" {
#       connection {
#         type     = "ssh"
#         user     = "centos"
#         password = "DevOps321"
#         # host     = self.public_ip
#         host     = aws_spot_instance_request.cheap_worker.private_ip 
#       } 
#     inline = [
#      "ansible-pull -U https://github.com/b49-clouddevops/ansible.git -e COMPONENT=${var.COMPONENT} -e ENV=dev -e TAG_NAME=${var.APP_VERSION} roboshop.yml"
#       ]
#     }
# }
