# Configure the AWS Provider
# Configure the AWS Provider
provider "aws" {
    region = "us-east-1"
}




resource "aws_vpc" "myapp" {
     cidr_block = "10.0.0.0/16"

  tags = {
    Name = "myappvpc"
  }
}

resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.myapp.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.gw.id}"
}


resource "aws_subnet" "public_1a" {
    vpc_id = "${aws_vpc.myapp.id}"
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1b"
    tags {
        Name = "sub1"
    }
}

resource "aws_subnet" "public_1b" {
    vpc_id = "${aws_vpc.myapp.id}"
    cidr_block = "10.0.2.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1c"
    tags {
        Name = "sub2"
    }
}


resource "aws_internet_gateway" "gw" {
    vpc_id = "${aws_vpc.myapp.id}"

    tags {
        Name = "myapp gw"
    }
}



resource "aws_security_group" "allow_ssh" {
  name = "allow_all"
  description = "Allow inbound SSH traffic from my IP"
  vpc_id = "${aws_vpc.myapp.id}"

  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

 tags {
    Name = "sg1"
  }
}

resource "aws_security_group" "web_server" {
  name = "web server"
  description = "Allow HTTP and HTTPS traffic in, browser access out."
  vpc_id = "${aws_vpc.myapp.id}"

  ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
      from_port = 0
      to_port = 65535
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

 tags {
    Name = "sg2"
  }

}







resource "aws_elb" "web-elb" {
  name = "web-elb"
  subnets  = ["${aws_subnet.public_1a.id}","${aws_subnet.public_1b.id}"]
  security_groups = ["${aws_security_group.web_server.id}","${aws_security_group.allow_ssh.id}"]

  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }

 health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    target = "HTTP:80/"
    interval = 30
  }


  cross_zone_load_balancing = true
  idle_timeout = 400
  connection_draining = true
  connection_draining_timeout = 400

  tags {
    Name = "Web ELB"
  }

}

resource "aws_key_pair" "deployer" {
 key_name = "myappkeypair"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDaj8nDzZrLXtfXpg3Uo71wrTfgVPMMLLdPRPPjj8hD1vRoAhkXpdluv4rDYJ6YucRZp7TGcnU2X6DaaEKMUayd7YAN99pf3v9Hm13n/dGc6rJZDTlu9jxaUuJIfSYQv4I7F/ZtixSsqYG1QAIw6KaRWhNO7OvfSMehMn0/4wVTS6fDJuCmo7MlFDU/KidRv3TT5sz+cc+OcYMUuczNtub3BSu+5x1sLLBQtYbntDs1oCAkJJ1yblE74dQMsNduC8fdFsRIJyRGGyQjCPB9gfImBlQu+zGgkgPmi2YEA1/x96v2jo6+L3ZIoFrpkmzuV8dGmmOrpEIEZZtKmi8DxP8L root@lap-am0044476.bccs.hutch.co.id"
}









resource "aws_launch_configuration" "machine-factory-v1" {
    name = "machine-factory-v1"
    image_id = "ami-b63769a1"
    security_groups = ["${aws_security_group.web_server.id}","${aws_security_group.allow_ssh.id}"]
    instance_type = "t2.micro"
    key_name = "myappkeypair"
    user_data       = "${file("userdata.sh")}"
    lifecycle              { create_before_destroy = true }

}
 
resource "aws_autoscaling_group" "machine-factory-v1" {
  availability_zones = ["us-east-1b", "us-east-1c"]
  name = "machine-factory-v1"
  min_size = 2
  max_size = 10
  desired_capacity = 3
  health_check_grace_period = 80
  health_check_type = "ELB"
  force_delete = false
  launch_configuration = "${aws_launch_configuration.machine-factory-v1.name}"
  load_balancers = ["${aws_elb.web-elb.name}"]
  vpc_zone_identifier = ["${aws_subnet.public_1a.id}","${aws_subnet.public_1b.id}"]
}



output "elb" {
  value = "${aws_elb.web-elb.name}"
}
output "launch_configuration" {
  value = "${aws_launch_configuration.machine-factory-v1.name}"
}

output "VPC" {
  value = "${aws_vpc.myapp.id}"
}
output "Autoscaling group" {
  value = "${aws_autoscaling_group.machine-factory-v1.name}"
}

output "subnet 1a id" {
  value = "${aws_subnet.public_1a.id}"
}

output "subnet 1b id" {
 value =  "${aws_subnet.public_1b.id}"
}

output "Gateway" {
  value = "${aws_internet_gateway.gw.id}"
}

output "Routing table" {
 value = "${aws_vpc.myapp.main_route_table_id}"
}

output "aws security group1 " {
value = "${aws_security_group.web_server.id}" 
}


output " aws security group_ssh" {
value = "${aws_security_group.allow_ssh.id}"
}


