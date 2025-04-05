module "s3" {
  source = "./modules/s3"

  bucket_name = var.bucket_name
  environment = var.environment
  tags        = var.tags
}

module "cloudfront" {
  source = "./modules/cloudfront"

  s3_bucket_id                  = module.s3.bucket_id
  s3_bucket_regional_domain_name = module.s3.bucket_regional_domain_name
  environment                    = var.environment
  tags                          = var.tags
}

# Update S3 bucket policy after CloudFront distribution is created
resource "aws_s3_bucket_policy" "website" {
  depends_on = [module.cloudfront]
  bucket     = module.s3.bucket_id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowCloudFrontServicePrincipal"
        Effect    = "Allow"
        Principal = { Service = "cloudfront.amazonaws.com" }
        Action    = "s3:GetObject"
        Resource  = "${module.s3.bucket_arn}/*"
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = module.cloudfront.distribution_arn
          }
        }
      }
    ]
  })
} 