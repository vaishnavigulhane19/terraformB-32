resource "aws_instance" "ec2" {
    ami = ami-0b1ed96948adabcd9
    instance_type = "t3.micro"
    key_name = "redhat"
    tags = {
        Name = "webserver"
    }
}