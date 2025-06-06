# 🚀 Deployment Guide

## 📋 Pre-Deployment Checklist

### ✅ Requirements Met
- [x] Modular Terraform structure
- [x] Remote GCS backend configuration
- [x] Environment separation (dev/staging/prod ready)
- [x] GitHub Actions CI/CD pipeline
- [x] Security best practices implemented
- [x] Comprehensive outputs for CI/CD reference

### 🔧 Setup Steps

#### 1. Initial Backend Setup
```bash
# Run this once to create GCS bucket and enable APIs
./scripts/setup-backend.sh
```

#### 2. Environment Configuration
```bash
cd environments/dev
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your values
```

#### 3. Local Deployment Test
```bash
# Initialize and deploy locally first
terraform init
terraform validate
terraform fmt
terraform plan
terraform apply
```

#### 4. GitHub CI/CD Setup
Configure these GitHub repository secrets:
- `GCP_SERVICE_ACCOUNT_KEY` - Base64 encoded service account JSON
- `OWNER_EMAIL` - Your email address
- `DB_PASSWORD` - Secure database password
- `SLACK_WEBHOOK_URL` - Optional Slack webhook

## 🏗️ What Gets Deployed

### Core Infrastructure
1. **Storage Bucket** - Static website hosting
2. **Cloud SQL** - PostgreSQL database with backups
3. **BigQuery** - Data warehouse with sample table
4. **Dataproc** - Managed Spark/Hadoop cluster
5. **Cloud Function** - Serverless Python function

### Security Features
- Remote state in GCS with versioning
- No hardcoded credentials
- Proper IAM roles and policies
- Network security controls
- Automated backups

### CI/CD Pipeline
- **Plan on PR** - Automatic plan generation and review
- **Apply on Merge** - Automated deployment to main branch
- **Output Extraction** - Post-deployment resource information
- **Slack Notifications** - Deployment status updates

## 🔄 Development Workflow

### Making Changes
1. **Create Feature Branch**: `git checkout -b feature/new-resource`
2. **Modify Terraform**: Edit modules or environments
3. **Test Locally**: `terraform plan` in environments/dev
4. **Create PR**: GitHub Actions runs plan automatically
5. **Review & Merge**: Plan review in PR comments
6. **Auto Deploy**: Merge triggers automatic apply

### Adding Environments
1. **Copy Dev**: `cp -r environments/dev environments/staging`
2. **Update Backend**: Change state prefix in backend.tf
3. **Configure Variables**: Update defaults and create new tfvars
4. **Update Workflows**: Add environment-specific GitHub Actions

## 📊 Post-Deployment

### Access Your Resources
```bash
# View all outputs
terraform output

# Specific resources
terraform output website_url
terraform output cloud_function_url
terraform output database_connection_name
```

### Verify Deployment
1. **Website**: Visit the website_url output
2. **Function**: Test the cloud_function_url
3. **Database**: Connect using provided connection details
4. **Dataproc**: Check cluster status in GCP Console

## 🛠️ Maintenance Tasks

### Regular Operations
- **State Management**: Terraform state is automatically managed in GCS
- **Backups**: Cloud SQL automated backups are enabled
- **Monitoring**: Set up Cloud Monitoring for alerts
- **Updates**: Regularly update Terraform provider versions

### Scaling
- **Horizontal**: Add more worker nodes to Dataproc
- **Vertical**: Increase machine types and disk sizes
- **Multi-Environment**: Deploy staging and production environments

## 🔍 Troubleshooting

### Common Issues
1. **Backend Access**: Ensure service account has Storage Admin role
2. **API Enablement**: Run setup script to enable required APIs
3. **Permissions**: Check IAM roles for service account
4. **State Lock**: Use `terraform force-unlock` if needed

### Debug Commands
```bash
# Verbose logging
TF_LOG=DEBUG terraform plan

# State inspection
terraform state list
terraform show

# Provider debug
terraform providers
```

## 🎯 Next Steps

1. **Test the Setup**: Follow the deployment steps
2. **Customize Modules**: Adapt modules to your specific needs
3. **Add Monitoring**: Implement Cloud Monitoring and alerting
4. **Security Hardening**: Review and enhance security settings
5. **Documentation**: Update README with project-specific details

---

**Ready to deploy! 🚀**
