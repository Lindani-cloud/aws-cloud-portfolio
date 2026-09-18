#!/usr/bin/env bash
set -euo pipefail

STACK_NAME="${STACK_NAME:-aws-cloud-portfolio}"
REGION="${AWS_REGION:-af-south-1}"
SITE_DIR="${SITE_DIR:-site}"
TEMPLATE_FILE="${TEMPLATE_FILE:-infrastructure/cloudformation.yaml}"

command -v aws >/dev/null 2>&1 || {
  echo "AWS CLI is required. Install and configure it before deploying." >&2
  exit 1
}

[[ -d "$SITE_DIR" ]] || {
  echo "Site directory '$SITE_DIR' was not found." >&2
  exit 1
}

echo "Validating CloudFormation template..."
aws cloudformation validate-template   --template-body "file://$TEMPLATE_FILE"   --region "$REGION" >/dev/null

echo "Deploying infrastructure stack '$STACK_NAME'..."
aws cloudformation deploy   --stack-name "$STACK_NAME"   --template-file "$TEMPLATE_FILE"   --region "$REGION"   --no-fail-on-empty-changeset

BUCKET_NAME="$(aws cloudformation describe-stacks   --stack-name "$STACK_NAME"   --region "$REGION"   --query "Stacks[0].Outputs[?OutputKey=='BucketName'].OutputValue"   --output text)"

DISTRIBUTION_ID="$(aws cloudformation describe-stacks   --stack-name "$STACK_NAME"   --region "$REGION"   --query "Stacks[0].Outputs[?OutputKey=='DistributionId'].OutputValue"   --output text)"

DOMAIN_NAME="$(aws cloudformation describe-stacks   --stack-name "$STACK_NAME"   --region "$REGION"   --query "Stacks[0].Outputs[?OutputKey=='DistributionDomainName'].OutputValue"   --output text)"

echo "Uploading website files to s3://$BUCKET_NAME..."
aws s3 sync "$SITE_DIR/" "s3://$BUCKET_NAME/" --delete --region "$REGION"

echo "Invalidating the CloudFront cache..."
aws cloudfront create-invalidation   --distribution-id "$DISTRIBUTION_ID"   --paths "/*" >/dev/null

echo "Deployment complete: https://$DOMAIN_NAME"
