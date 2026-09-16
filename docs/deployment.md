# Deployment Notes

This project can be hosted on AWS using a private S3 bucket and CloudFront. The S3 bucket stores the website files, while CloudFront provides the public HTTPS endpoint.

## Architecture

- Amazon S3 stores the static files from the `site/` folder.
- S3 public access is blocked so the bucket is not directly exposed.
- CloudFront reads from S3 through Origin Access Control.
- CloudFront redirects viewers to HTTPS and serves `index.html` as the home page.
- The stack outputs the bucket name and CloudFront domain for the demo.

## Console deployment path

1. Open the AWS Management Console and go to CloudFormation.
2. Create a new stack using `infrastructure/cloudformation.yaml`.
3. Keep `PriceClass_100` for a cost-conscious demo deployment.
4. After the stack completes, open the S3 bucket from the stack outputs.
5. Upload the files from the `site/` folder into the bucket.
6. Open the CloudFront domain name from the stack outputs to view the portfolio.

## Optional AWS CLI deployment

```bash
aws cloudformation deploy \
  --stack-name cloud-portfolio-demo \
  --template-file infrastructure/cloudformation.yaml

BUCKET_NAME=$(aws cloudformation describe-stacks \
  --stack-name cloud-portfolio-demo \
  --query "Stacks[0].Outputs[?OutputKey=='BucketName'].OutputValue" \
  --output text)

aws s3 sync site/ "s3://$BUCKET_NAME" --delete
```

## Demo talking points

- Explain why S3 is used for object storage.
- Explain why CloudFront is placed in front of S3.
- Point out that the bucket blocks public access, which is safer than exposing S3 directly.
- Show the CloudFormation template as infrastructure-as-code.
- Mention that this is intentionally small so it matches an intro cloud portfolio project.

## Cleanup

To avoid ongoing AWS costs, delete the CloudFormation stack when the demo is finished. Empty the S3 bucket first if CloudFormation cannot delete it automatically.
