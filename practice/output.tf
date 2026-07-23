output "aws_s3_arn" {
    value = aws_s3_bucket.bucket.id
}

output "website_url" {
  value = aws_s3_bucket_website_configuration.website.website_endpoint
}