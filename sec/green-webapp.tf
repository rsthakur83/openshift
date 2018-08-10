provider "aws" {
    region = "us-east-1"
}





resource "aws_launch_configuration" "machine-factory-v1" {
    name = "machine-factory-v1"
    image_id = "ami-b63769a1"
   security_groups = ["sg-08e8eebe7719e1032","sg-0afea61c669bbe25b"]
    instance_type = "t2.micro"
    user_data       = "${file("userdata.sh")}"
    lifecycle              { create_before_destroy = true }
}
