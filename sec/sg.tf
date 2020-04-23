provider "aws" {
    region = "us-east-1"
}





resource "aws_launch_configuration" "machine-factory-v1" {
    name = "machine-factory-v1"
    image_id = "ami-b63769a1"
    security_groups = ["sg-042f17c7768323497","sg-09b129c9635460630"]
    instance_type = "t2.micro"
    user_data       = "${file("userdata.sh")}"
    lifecycle              { create_before_destroy = true }
}
