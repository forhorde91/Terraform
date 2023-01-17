provider "aws" {
    region = "eu-west-2"
}

resource "aws_vpc" "MyVPC" {
    cidr_block = "10.10.0.0/16"
    tags = { 
	Name = "MyVPC"
	}
  }


resource "aws_subnet" "subnet1" {
  depends_on = [
    aws_vpc.MyVPC
  ]
   vpc_id = aws_vpc.MyVPC.id
   cidr_block = "10.10.1.0/24"
   availability_zone = "eu-west-2"
   map_public_ip_on_launch = true
    tags = { 
	Name = "Public Subnet"
	}
  }

resource "aws_subnet" "subnet2" {
  depends_on = [
    aws_vpc.MyVPC
  ]
   vpc_id = aws_vpc.MyVPC.id
   cidr_block = "10.10.2.0/24"
   availability_zone = "eu-west-2"
    tags = { 
	Name = "Private Subnet"
	}
  }

resource "aws_internet_gateway" "Internet_Gateway" {
  depends_on = [
    aws_vpc.MyVPC,
    aws_subnet.subnet1,
    aws_subnet.subnet2
  ]
    vpc_id = aws_vpc.MyVPC.id
    tags = { 
	Name = "IGW-Public-&-Private-VPC"
	}
  }


#resource "aws_instance" "ec2-instance" {
#   ami = "ami-01b8d743224353ffe"
#   instance_type = "t2.micro"
# }