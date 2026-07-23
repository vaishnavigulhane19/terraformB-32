data "aws_vpc" "default" {
    default = true

    }
resource "aws_s3_bucket" "bucket" {
    bucket = "vaishnavi-amazons-bucket-362"
    tags = {
        Name = "bucket"
    } 
}

resource "aws_s3_object" "object" {
    bucket = aws_s3_bucket.bucket.bucket
    source = "./file.txt"
    key = "terraformfile"

}

resource "aws_security_group" "sg" {
    name = "sg"
    description = "sg"
    vpc_id = data.aws_vpc.default.id

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    egress {
        from_port = 0
        to_port = 0
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]

    }

}

resource "aws_instance" "ec2" {
    ami = var.ami
    key_name = var.key_name
    instance_type = var.instance_type
    vpc_security_group_ids = [aws_security_group.sg.id]
    disable_api_termination = false
    user_data = file("/root/terraformB-32/practice/user-data.sh")
    tags = {
        Name = "webserver"
    }

}