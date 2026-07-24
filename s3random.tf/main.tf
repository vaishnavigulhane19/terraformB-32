resource "random_id" "bucket" {
    count = 10
    byte_length = 4

}


resource "aws_s3_bucket" "bucket" {
    count = 10
    bucket = "bucket-of-navi-khsn-${random_id.bucket.hex}"
    force_destroy = true
    tags = {
        Name = "bucket-${count.index + 1}"
    }
}