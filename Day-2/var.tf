variable "ami" {
    default = "ami-0b1ed96948adabcd9"

}

variable "instance_type" {
    default = "t3.micro"
}

variable "key_name" {
    default = "redhat"
}

variable "volume_size" {
    default = 8
}

variable "vplume_type" {
    default = "gp3"
}

variable "tags" {
    type = map(string)
    default = {
        Name = "webserver"
    }
}