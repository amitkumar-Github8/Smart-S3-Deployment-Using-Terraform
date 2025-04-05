variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
  default     = "my-static-website"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "tags" {
  description = "Default tags for all resources"
  type        = map(string)
  default = {
    Project     = "StaticWebsite"
    ManagedBy   = "Terraform"
    Environment = "dev"
  }
} 