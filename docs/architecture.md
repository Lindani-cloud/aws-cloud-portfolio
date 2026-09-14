# CloudLaunch Architecture

## Request flow

1. A visitor opens the CloudFront distribution URL using HTTPS.
2. CloudFront checks its edge cache for the requested website file.
3. When required, CloudFront retrieves the file from the private S3 bucket.
4. Origin Access Control authorizes CloudFront without exposing the bucket.
5. CloudFront returns and caches the file for later requests.

## Design decisions

### Private S3 bucket

The S3 bucket will keep Block Public Access enabled. Website visitors will not
access S3 directly.

### CloudFront delivery

CloudFront provides the public HTTPS endpoint. The distribution will use the
regular S3 bucket origin with Origin Access Control rather than an S3 website
endpoint.

### Versioning

S3 Versioning will be enabled before website files are uploaded. This provides
a simple demonstration of recovering an overwritten object.

### Cost monitoring

An AWS zero-spend or low-cost budget will be configured before deployment.
No paid custom domain is required for this project.

## Evidence to capture

Only screenshots that contain no secrets or sensitive billing information will
be stored in the repository:

- S3 bucket properties showing versioning
- S3 permissions showing public access blocked
- CloudFront distribution status and domain
- Deployed website through HTTPS
- AWS budget configuration without personal information
