provider "aws" {
    region = "us-east-1"
}





resource "aws_launch_configuration" "machine-factory-v1" {
    name = "machine-factory-v1"
    image_id = "ami-b63769a1"
   security_groups = ["sg-00bf40f60927b05c0","sg-0b6a3679a1405c450"]
    instance_type = "t2.micro"
    user_data       = "${file("userdata.sh")}"
    lifecycle              { create_before_destroy = true }
}
