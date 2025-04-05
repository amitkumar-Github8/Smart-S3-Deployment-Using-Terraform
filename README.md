# Smart S3 Deploy - Static Website Hosting

A Terraform-based solution for deploying static websites to AWS S3 with CloudFront distribution. This project provides a secure, scalable, and cost-effective way to host static websites on AWS.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## 🌟 Features

- **S3 Bucket Configuration**
  - Secure bucket with public access blocked
  - Server-side encryption enabled
  - Versioning enabled for backup and rollback
  - Lifecycle rules for cost optimization
  - CORS configuration for web assets
  - Website hosting configuration

- **CloudFront Distribution**
  - Global content delivery network
  - HTTPS support
  - Optimized caching for different file types
  - Custom error responses
  - Origin Access Identity for secure S3 access

- **Infrastructure as Code**
  - Modular Terraform configuration
  - Easy to customize and extend
  - Follows AWS best practices
  - Cost-optimized design

## 📋 Prerequisites

Before you begin, ensure you have the following installed:

- [Terraform](https://www.terraform.io/downloads.html) (v1.2.0 or later)
- [AWS CLI](https://aws.amazon.com/cli/) configured with appropriate credentials
- An AWS account with permissions to create S3 buckets and CloudFront distributions

## 🚀 Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/smart-s3-deploy.git
cd smart-s3-deploy
```

### 2. Configure AWS Credentials

Make sure your AWS credentials are configured:

```bash
aws configure
```

Enter your AWS Access Key ID, Secret Access Key, default region (e.g., us-east-1), and output format (json).

### 3. Customize the Configuration

Copy the example variables file and edit it with your settings:

```bash
cp terraform.tfvars.example terraform.tfvars
```

Edit the `terraform.tfvars` file to customize your deployment:

```hcl
# AWS Region
aws_region = "us-east-1"

# Environment
environment = "production"

# Tags
tags = {
  Terraform  = "true"
  ManagedBy  = "terraform"
  Project    = "smart-s3-deploy"
  Owner      = "Your-Name"
  CostCenter = "your-cost-center"
}
```

### 4. Initialize Terraform

```bash
terraform init
```

### 5. Apply the Terraform Configuration

```bash
terraform plan
terraform apply
```

### 6. Upload Your Website Files

After the infrastructure is created, you can upload your website files to the S3 bucket using either the automated method or manually through the AWS Console.

#### Option 1: Manual Upload (Using AWS Console)

1. Log in to the AWS Management Console
2. Navigate to the S3 service
3. Find and select your bucket (e.g., `my-static-website-i91hat9g`)
4. Click "Upload"
5. Upload your website files:
   - `index.html` - Main website page
   - `error.html` - Error page
   - Any other assets (CSS, JavaScript, images)
6. Set appropriate content types:
   - HTML files: `text/html`
   - CSS files: `text/css`
   - JavaScript files: `application/javascript`
   - Images: `image/jpeg`, `image/png`, etc.
7. Click "Upload" to complete the process

### 7. Access Your Website

Get your CloudFront domain name:

```bash
terraform output cloudfront_domain_name
```

Access your website using the CloudFront URL: `https://<cloudfront-domain-name>/`

## 📁 Project Structure

```
smart-s3-deploy/
├── main.tf                  # Main Terraform configuration
├── variables.tf             # Input variables
├── outputs.tf               # Output values
├── provider.tf              # AWS provider configuration
├── terraform.tfvars         # Variable values
├── modules/
│   ├── s3/                  # S3 bucket module
│   │   ├── main.tf          # S3 bucket resources
│   │   ├── variables.tf     # S3 module variables
│   │   └── outputs.tf       # S3 module outputs
│   └── cloudfront/          # CloudFront module
│       ├── main.tf          # CloudFront resources
│       ├── variables.tf     # CloudFront module variables
│       └── outputs.tf       # CloudFront module outputs
└── website/                 # Sample website files
    ├── index.html           # Home page
    └── error.html           # Error page
```

## 🔧 Customization

### Modifying the S3 Bucket Configuration

Edit the `modules/s3/main.tf` file to customize the S3 bucket configuration:

- Change lifecycle rules
- Modify CORS settings
- Adjust versioning settings

### Modifying the CloudFront Distribution

Edit the `modules/cloudfront/main.tf` file to customize the CloudFront distribution:

- Change cache behaviors
- Modify TTL settings
- Add custom error responses
- Configure additional origins

## 💰 Cost Optimization

This project includes several cost optimization features:

- **S3 Lifecycle Rules**: Automatically clean up old versions and incomplete uploads
- **CloudFront Price Class**: Uses PriceClass_100 (North America and Europe only) for lower costs
- **Optimized Cache Settings**: Different TTLs for different file types to reduce origin requests

### Estimated Monthly Costs

| Service    | Usage Estimate | Monthly Cost |
|------------|----------------|--------------|
| S3         | 1 GB storage   | ~$0.023      |
| CloudFront | 10 GB transfer | ~$0.85       |
| **Total**  |                | **~$0.87**   |

*Note: Actual costs may vary based on usage patterns and region.*

## 🔒 Security Considerations

- S3 bucket has public access blocked
- CloudFront uses Origin Access Identity to access S3
- Server-side encryption enabled for S3 objects
- HTTPS enforced through CloudFront

## 🧹 Cleanup

To remove all resources created by this project:

```bash
# Empty the S3 bucket first
S3_BUCKET=$(terraform output -raw s3_bucket_name)
aws s3 rm s3://$S3_BUCKET --recursive

# Then destroy the Terraform resources
terraform destroy
```

## 🐛 Troubleshooting

### CloudFront Distribution Not Working

1. Check if the distribution is fully deployed (can take 10-15 minutes)
2. Verify that the S3 bucket policy allows CloudFront access
3. Create an invalidation for `/*` to refresh the cache

### S3 Website Endpoint Not Working

The S3 website endpoint is not accessible by default because public access is blocked. Use the CloudFront URL instead.

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👥 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📞 Support

If you encounter any issues or have questions, please [open an issue](https://github.com/yourusername/smart-s3-deploy/issues) in the GitHub repository. 