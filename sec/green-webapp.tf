provider "aws" {
    region = "us-east-1"
}





resource "aws_launch_configuration" "machine-factory-v1" {
    name = "machine-factory-v1"
    image_id = "ami-b63769a1"
security_groups = ["sg-0f7de5d6378a84493","sg-00bd08b1bb3ec62d8"]
    instance_type = "t2.micro"
    user_data       = "${file("userdata.sh")}"
    lifecycle              { create_before_destroy = true }
}
