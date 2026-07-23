resource "aws_s3_bucket" "s3" {
    bucket = var.vaishnavi-amazon-busk198nisnbnn9

    tags = {
        Name = "s3"
    
    }

resource "aws_s3_bucket_pulic_access_blockblock_public" {
    bucket = aws_s3_bucket.s3.id
    block_public_acls = true
    block_public_policy = true
    ignore_public_acls = true
    restrict_public_bucket 
    
    }
}
