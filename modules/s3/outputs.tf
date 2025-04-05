output "bucket_id" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.website.id
}

output "bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = aws_s3_bucket.website.arn
}

output "bucket_regional_domain_name" {
  description = "The bucket region-specific domain name"
  value       = aws_s3_bucket.website.bucket_regional_domain_name
}

output "bucket_website_endpoint" {
  description = "The website endpoint of the S3 bucket"
  value       = "http://${aws_s3_bucket.website.id}.s3-website-${data.aws_region.current.name}.amazonaws.com"
}

data "aws_region" "current" {} 