#!/bin/bash

# Script to create GCS bucket for Terraform remote state
# Run this script before running terraform for the first time

set -e

# Configuration
PROJECT_ID="tst-devops-intrvw"
BUCKET_NAME="terraform-state-tst-devops-intrvw"
REGION="us-west1"

echo "🚀 Setting up Terraform remote backend..."

# Check if gcloud is installed
if ! command -v gcloud &> /dev/null; then
    echo "❌ gcloud CLI is not installed. Please install it first."
    exit 1
fi

# Check if logged in to gcloud
if ! gcloud auth list --filter=status:ACTIVE --format="value(account)" | grep -q .; then
    echo "❌ Not authenticated with gcloud. Please run 'gcloud auth login' first."
    exit 1
fi

# Set the project
echo "📋 Setting project to $PROJECT_ID..."
gcloud config set project $PROJECT_ID

# Check if bucket already exists
if gsutil ls gs://$BUCKET_NAME &> /dev/null; then
    echo "✅ Bucket gs://$BUCKET_NAME already exists."
else
    echo "🗄️  Creating GCS bucket for Terraform state..."
    
    # Create bucket
    gsutil mb -p $PROJECT_ID -c STANDARD -l $REGION gs://$BUCKET_NAME
    
    # Enable versioning
    gsutil versioning set on gs://$BUCKET_NAME
    
    # Set bucket-level IAM (optional - restrict access)
    # gsutil iam ch serviceAccount:terraform@$PROJECT_ID.iam.gserviceaccount.com:objectAdmin gs://$BUCKET_NAME
    
    echo "✅ Created bucket gs://$BUCKET_NAME with versioning enabled."
fi

# Enable required APIs
echo "🔧 Enabling required Google Cloud APIs..."
gcloud services enable \
    cloudresourcemanager.googleapis.com \
    storage-api.googleapis.com \
    compute.googleapis.com \
    sqladmin.googleapis.com \
    bigquery.googleapis.com \
    cloudfunctions.googleapis.com \
    dataproc.googleapis.com \
    cloudbuild.googleapis.com \
    iam.googleapis.com

echo "✅ Required APIs enabled."

echo ""
echo "🎉 Backend setup complete!"
echo ""
echo "Next steps:"
echo "1. Navigate to environments/dev directory: cd environments/dev"
echo "2. Copy terraform.tfvars.example to terraform.tfvars"
echo "3. Update terraform.tfvars with your values"
echo "4. Run: terraform init"
echo "5. Run: terraform plan"
echo "6. Run: terraform apply"
echo ""
echo "For CI/CD, configure these GitHub secrets:"
echo "- GCP_SERVICE_ACCOUNT_KEY (base64 encoded service account JSON)"
echo "- OWNER_EMAIL (your email address)"
echo "- DB_PASSWORD (secure database password)"
echo "- SLACK_WEBHOOK_URL (optional, for notifications)"
