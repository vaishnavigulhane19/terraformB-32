variable "ami" {
    default = "ami-0b1ed96948adabcd9"
}

variable "instance_type" {
     default = "t3.micro"
}
   
variable "key_name" {
    default = "redaht"
}

variable "volume_type" {
    default = "t3.micro"
}

variable "volume_size" {
    default = 8
}

variable "tags" {
    type = map(string)
    default = {
        Name = "webserver"
    }
}