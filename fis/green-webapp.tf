provider "aws" {
    region = "us-east-1"
}





resource "aws_launch_configuration" "machine-factory-v2" {
    name = "machine-factory-v2"
    image_id = "ami-b63769a1"
    security_groups = ["sg-0a6d2c9bddde5df72","sg-01e992754cd3edbe2"]
    instance_type = "t2.micro"
    user_data       = "${file("userdata.sh")}"
    lifecycle              { create_before_destroy = true }
}
