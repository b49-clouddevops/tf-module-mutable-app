# Request a spot instance at $0.03
resource "aws_spot_instance_request" "cheap_worker" {
  ami           = ????
  spot_price    = "0.03"
  instance_type = "c4.xlarge"

  tags = {
    Name = "CheapWorker"
  }
}