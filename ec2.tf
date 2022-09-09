# Request a spot instance
resource "aws_spot_instance_request" "spot" {
  count                   = var.SPOT_INSTANCE_COUNT
  ami                     = data.aws_ami.ami
  instance_type           = var.INSTANCE_TYPE
  wait_for_fulfillment    = true 
  vpc_security_group_ids  = [aws_security_group.allow_app.id]
  subnet_id               
  tags = {
    Name = "${var.COMPONENT}-${ENV}"
  }
}

# Creates On Demand Instance
resource "aws_instance" "od" {
  count                   = var.OD_INSTANCE_COUNT
  ami                     = data.aws_ami.ami
  instance_type           =  var.INSTANCE_TYPE


  tags = {
    Name = "${var.COMPONENT}-${ENV}"
  }
}



# resource "aws_spot_instance_request" "cheap_worker" {
#   ami                    = data.aws_ami.base-ami.image_id
#   instance_type          = "t3.micro"
 
#   vpc_security_group_ids = [aws_security_group.allow_all.id]


# }

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
