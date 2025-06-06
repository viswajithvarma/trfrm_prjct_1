# Terraform GCP Infrastructure with CI/CD

A production-ready Terraform infrastructure setup for Google Cloud Platform with modular design, remote state management, and GitHub Actions CI/CD pipeline.

## 🏗️ Architecture Overview

This project demonstrates enterprise-level Terraform best practices:

- **Modular Design**: Reusable modules for different GCP services
- **Environment Separation**: Isolated environments (dev/staging/prod)
- **Remote State**: GCS backend with state locking and versioning
- **CI/CD Pipeline**: GitHub Actions for automated plan/apply workflows
- **Security**: No hardcoded credentials, proper IAM, secrets management

## 📁 Project Structure

```
terraform-gcp/
├── .github/workflows/          # GitHub Actions CI/CD pipelines
│   ├── terraform-plan.yml      # Plan on PRs
│   └── terraform-apply.yml     # Apply on main branch
├── environments/               # Environment-specific configurations
│   └── dev/                   # Development environment
│       ├── backend.tf         # Remote state configuration
│       ├── provider.tf        # Provider configuration
│       ├── main.tf           # Main infrastructure using modules
│       ├── variables.tf      # Environment variables
│       ├── outputs.tf        # Environment outputs
│       └── terraform.tfvars.example  # Example variables
├── modules/                   # Reusable Terraform modules
│   ├── storage/              # GCS bucket for website hosting
│   ├── database/             # Cloud SQL PostgreSQL
│   ├── bigquery/             # BigQuery dataset and tables
│   ├── compute/              # Dataproc clusters
│   └── functions/            # Cloud Functions
├── scripts/
│   └── setup-backend.sh     # Backend setup script
├── website/                  # Static website files
│   └── index.html
├── .gitignore               # Git ignore patterns
└── README.md               # This file
```

## 🚀 Quick Start

### Prerequisites

1. **Google Cloud Account** with billing enabled
2. **gcloud CLI** installed and configured
3. **Terraform** >= 1.0 installed
4. **GitHub repository** for CI/CD (optional)

### 1. Setup Remote Backend

First, create the GCS bucket for remote state:

```bash
# Make script executable
chmod +x scripts/setup-backend.sh

# Run backend setup
./scripts/setup-backend.sh
```

### 2. Configure Environment

```bash
# Navigate to dev environment
cd environments/dev

# Copy example variables
cp terraform.tfvars.example terraform.tfvars

# Edit with your values
vim terraform.tfvars
```

Example `terraform.tfvars`:
```hcl
project_id   = "your-gcp-project-id"
region       = "us-west1"
location     = "US"
environment  = "dev"
owner_email  = "your-email@example.com"
db_password  = "your-secure-password"
```

### 3. Deploy Infrastructure

```bash
# Initialize Terraform
terraform init

# Validate configuration
terraform validate

# Format code
terraform fmt

# Plan deployment
terraform plan

# Apply changes
terraform apply
```

## 🔧 Deployed Resources

The infrastructure deploys the following GCP services:

### Storage Module
- **GCS Bucket**: Website hosting with public access
- **Static Website**: Serves `index.html` from bucket
- **Function Source**: Stores Cloud Function deployment packages

### Database Module
- **Cloud SQL**: PostgreSQL instance with automated backups
- **Database**: Application database with user accounts
- **Security**: Network access controls and encryption

### BigQuery Module
- **Dataset**: Analytics data warehouse
- **Tables**: Structured data storage with partitioning
- **IAM**: Proper access controls for data access

### Compute Module
- **Dataproc Cluster**: Managed Spark/Hadoop cluster
- **Auto-scaling**: Configurable cluster sizing
- **Security**: Shielded VMs and network isolation

### Functions Module
- **Cloud Function**: Serverless Python function
- **HTTP Trigger**: Public API endpoint
- **Source Management**: Automated deployment from GCS

## 🔄 CI/CD Pipeline

### GitHub Actions Workflows

#### 1. Plan Workflow (`terraform-plan.yml`)
- **Trigger**: Pull requests to main branch
- **Actions**: 
  - Terraform format check
  - Validation
  - Plan generation
  - PR comment with plan details

#### 2. Apply Workflow (`terraform-apply.yml`)
- **Trigger**: Push to main branch
- **Actions**:
  - Terraform apply
  - Output extraction
  - Deployment summary
  - Slack notifications (optional)

### Required GitHub Secrets

Configure these secrets in your GitHub repository:

| Secret | Description | Example |
|--------|-------------|---------|
| `GCP_SERVICE_ACCOUNT_KEY` | Base64 encoded service account JSON | `ewogICJ0eXBlIjogInNlcnZpY2VfYWNjb3VudCIs...` |
| `OWNER_EMAIL` | Your email address for resource ownership | `admin@example.com` |
| `DB_PASSWORD` | Secure database password | `SecurePassword123!` |
| `SLACK_WEBHOOK_URL` | Slack webhook for notifications (optional) | `https://hooks.slack.com/...` |

### Service Account Setup

1. Create a service account for Terraform:
```bash
gcloud iam service-accounts create terraform-deploy \
    --display-name="Terraform Deployment Account"
```

2. Assign necessary roles:
```bash
gcloud projects add-iam-policy-binding YOUR_PROJECT_ID \
    --member="serviceAccount:terraform-deploy@YOUR_PROJECT_ID.iam.gserviceaccount.com" \
    --role="roles/editor"
```

3. Generate and download key:
```bash
gcloud iam service-accounts keys create terraform-key.json \
    --iam-account="terraform-deploy@YOUR_PROJECT_ID.iam.gserviceaccount.com"
```

4. Base64 encode for GitHub secret:
```bash
base64 terraform-key.json
```

## 🛡️ Security Best Practices

### ✅ Implemented Security Measures

- **No Hardcoded Credentials**: All secrets managed via variables and GitHub secrets
- **Remote State**: Encrypted state storage in GCS with versioning
- **Network Security**: Proper firewall rules and private networks
- **IAM**: Least privilege access controls
- **Backup Strategy**: Automated backups for stateful services
- **Encryption**: Data encrypted at rest and in transit

### 🔒 Additional Recommendations

1. **Enable audit logging** for all GCP services
2. **Use VPC networks** instead of default network
3. **Implement Cloud KMS** for additional encryption
4. **Set up monitoring** with Cloud Monitoring
5. **Regular security scanning** with Cloud Security Command Center

## 📊 Outputs and Monitoring

After deployment, access your resources:

```bash
# Get all outputs
terraform output

# Get specific output
terraform output website_url
terraform output cloud_function_url
```

Key outputs include:
- **Website URL**: Public URL for your static website
- **Function URL**: API endpoint for your Cloud Function  
- **Database IP**: Connection details for your database
- **Dataproc Cluster**: Big data processing cluster details

## 🔄 Workflow Examples

### Making Changes

1. **Create Feature Branch**:
```bash
git checkout -b feature/new-resource
```

2. **Make Changes**: Modify Terraform files

3. **Test Locally**:
```bash
cd environments/dev
terraform plan
```

4. **Create Pull Request**: Push and create PR
   - GitHub Actions will run `terraform plan`
   - Review plan in PR comments

5. **Merge to Main**: 
   - GitHub Actions will run `terraform apply`
   - Resources deployed automatically

### Adding New Environments

1. **Copy Dev Environment**:
```bash
cp -r environments/dev environments/staging
```

2. **Update Configuration**:
   - Modify `backend.tf` with new state prefix
   - Update `variables.tf` defaults
   - Create environment-specific `terraform.tfvars`

3. **Update Workflows**: Add staging-specific GitHub Actions

## 🐛 Troubleshooting

### Common Issues

#### 1. Backend Initialization Fails
```bash
Error: Failed to get existing workspaces: querying Cloud Storage failed
```
**Solution**: Run the backend setup script and ensure bucket exists.

#### 2. Permission Denied
```bash
Error: Error creating instance: googleapi: Error 403: Insufficient Permission
```
**Solution**: Check service account has required IAM roles.

#### 3. API Not Enabled
```bash
Error: Error 403: Cloud SQL Admin API has not been used
```
**Solution**: Enable required APIs using the setup script.

#### 4. State Lock Issues
```bash
Error: Error locking state: Error acquiring the state lock
```
**Solution**: Check for concurrent Terraform runs or manually unlock:
```bash
terraform force-unlock LOCK_ID
```

### Debug Commands

```bash
# Check Terraform version
terraform version

# Validate configuration
terraform validate

# Check formatting
terraform fmt -check -recursive

# Show current state
terraform show

# List resources
terraform state list

# Debug with verbose logging
TF_LOG=DEBUG terraform plan
```

## 📚 Additional Resources

- [Terraform GCP Provider Documentation](https://registry.terraform.io/providers/hashicorp/google/latest/docs)
- [Google Cloud Architecture Center](https://cloud.google.com/architecture)
- [Terraform Best Practices](https://www.terraform.io/docs/cloud/guides/recommended-practices/index.html)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

**Happy Terraforming! 🚀**
