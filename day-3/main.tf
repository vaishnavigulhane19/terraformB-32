resource "aws_vpc" "my_vpc" {
    cidr_block = var.vpc_cidr

    tags = {
        Name = "my-vpc"
    }
}

resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.public_subnet_cidr
    availability_zone = var.public_az
    map_public_ip_on_launch = true
    tags = {
        Name = "public-subnet"
    }
    }

resource "aws_subnet" "private_subnet" {
    vpc_id = var.private_subnet_cidr
    availability_zone = var.private_az
    tags = {
        Name = "private-subnet"
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.my-vpc.id
    tags = {
        Name = "igw"
    }
}

resource "aws_eip" "nat_eip" {
    domain = "vpc"
    tags = {
        Name = "nat-eip"
    }
}

resource "aws_nat_gateway" "nat_gateway" {
    subnet_id = aws_subnet.public_subnet.id
    allocation_id = aws_eip.nat_eip.id
    tags = {
        Name = "nat-gateway"
    }
}

resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.my-vpc.id    
    route {
        gateway_id = aws_internet_gateway.igw.id
        cidr_block = "0.0.0.0/0" 
        }
    }

resource "aws_public_association" "public_asso" {
    subnet_id = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table" "private_rt" {
    vpc_id = aws_vpc.my_vpc.id
    route {
        gateway_id = aws_nat_gateway.nat_gateway.id
        cidr_block = "0.0.0.0/0"
    }
}

resource "aws_private_association" "private_asso" {
    subnet_id = aws_subnet.private_subnet.id
    route_table_id = aws_route_table.private_rt.id
}

resource "aws_security_group" "my_sg" {
    name = "my_sg_vpc" 
    description = "my_sg_vpc"
    vpc_id = aws_vpc.my_vpc.id

    ingress {
        from_port = var.ssh_port
        to_port = var.ssh_port
        protocol = tcp
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    ingress {
        from_port = var.http_port
        to_port = var.http_port
        protocol =  tcp
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "my_sg_vpc"
    }
}   

resource "aws_instance" "public_instance" {
    ami = var.ami
    instance_type = var.instance_type 
    key_name = var.key_name
    vpc_security_group_ids = [aws_security_group.my_sg.id]
    subnet_id = aws_subnet.public_subnet.id
    associate_public_ip_address = true
    user_data = file("/root/terrafoemB-32/day-3/user_data.sh")
    tags = {
        Name = "public-instance"
    }
}    

resource "aws_instance" "private_instance" {
    ami = var.ami 
    instance_type = var.instance_type
    key_name = var.key_name
    vpc_security_group_ids = [aws_security_group.my_sg.id]
    subnet_id = aws_subnet.private_subnet.id 
    user_data = file("/root/terraform-b32/day-3-vpc/user-data.sh")

    tags = {
        Name = "private-instance"
    }
}