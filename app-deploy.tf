resource "null_resource" "app_deploy" {
#   triggers = {    
#         a = timestamp()  # Everytime you run, when compared to the last time, the time changes, so it will be triggered all the time.
#   }
  count = var.SPOT_INSTANCE_COUNT + var.OD_INSTANCE_COUNT
  provisioner "remote-exec" {
      connection {
        type     = "ssh"
        user     =  jsondecode(data.aws_secretsmanager_secret_version.secrets.secret_string)["DOCDB_USERNAME"]
        password = 
        # host     = self.public_ip
        host     = element(local.ALL_INSTANCE_PRIVATE_IPS, count.index)
      } 
    inline = [
     "ansible-pull -U https://github.com/b49-clouddevops/ansible.git -e COMPONENT=${var.COMPONENT} -e ENV=dev -e TAG_NAME=${var.APP_VERSION} roboshop.yml"
      ]
    }
}
