provider "aws" {
    region = "us-east-2"
}





resource "aws_launch_configuration" "machine-factory-v2" {
    name = "machine-factory-v2"
    image_id = "ami-0932686c"
    security_groups = ["sg-02b4c8d798290b687","sg-004c0c953c67a97e4"]
    instance_type = "t2.micro"
    user_data       = "${file("userdata.sh")}"
    lifecycle              { create_before_destroy = true }
}
