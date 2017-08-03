provider "aws" {
    region = "us-east-1"
}





resource "aws_launch_configuration" "machine-factory-v2" {
    name = "machine-factory-v2"
    image_id = "ami-b63769a1"
    security_groups = ["sg-d6b454a6","sg-80ae4ef0"]
    instance_type = "t2.micro"
    user_data       = "${file("userdata.sh")}"
    lifecycle              { create_before_destroy = true }
}
