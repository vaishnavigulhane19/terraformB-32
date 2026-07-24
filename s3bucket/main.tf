resource "aws_s3_bucket" "bucket" {
    count = 10 
    bucket = "my-navi-bucket-navi-uhi-${index + 1}"
    force_destroy = true 
}