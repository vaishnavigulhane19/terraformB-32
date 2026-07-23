variable "aws_region" {
    description = "The AWS region to deploy the bucket in"
    type = string
    default = "ap-south-1"
    
}

variable "bucket_name" {
    description = "The globally unique name of the S3 bucket"
    type = string
}