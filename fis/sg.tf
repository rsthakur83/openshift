provider "aws" {
    region = "us-east-1"
}





resource "aws_launch_configuration" "machine-factory-v2" {
    name = "machine-factory-v2"
    image_id = "ami-b63769a1"
    security_groups = ["sg-0f860f81de12477f4","sg-0714e52947092036c"]
    instance_type = "t2.micro"
    user_data       = "${file("userdata.sh")}"
    lifecycle              { create_before_destroy = true }
}
