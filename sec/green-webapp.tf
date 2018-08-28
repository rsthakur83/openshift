provider "aws" {
    region = "us-east-1"
}





resource "aws_launch_configuration" "machine-factory-v1" {
    name = "machine-factory-v1"
    image_id = "ami-b63769a1"
   security_groups = ["sg-035b031e6056f86e0","sg-0b41dfcd23f97b7c4"]
    instance_type = "t2.micro"
    user_data       = "${file("userdata.sh")}"
    lifecycle              { create_before_destroy = true }
}
