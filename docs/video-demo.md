# YouTube Demo Walkthrough

This outline keeps the demonstration short, practical, and connected to the AWS Cloud 101 and AWS Management Console learning outcomes.

## Suggested length

Aim for **4–6 minutes**. Record the browser, terminal, and AWS Console while narrating the steps below.

## 1. Introduction — 30 seconds

> Hi, I am Nkosingiphile Sukati. This project demonstrates a secure, cost-conscious static portfolio deployed on AWS. I used Amazon S3 for storage, CloudFront for global HTTPS delivery, and CloudFormation to define the infrastructure as code.

Show the repository README and briefly point out the `site`, `infrastructure`, `deploy`, and `docs` folders.

## 2. Architecture — 45 seconds

Open `docs/architecture.md` and explain:

- Website files are stored in a private S3 bucket.
- Direct public access to the bucket is blocked.
- CloudFront is the public entry point and redirects HTTP traffic to HTTPS.
- Origin Access Control permits only the CloudFront distribution to read S3 objects.
- CloudFormation creates the resources consistently.

## 3. Infrastructure code — 60 seconds

Open `infrastructure/cloudformation.yaml` and highlight:

- S3 server-side encryption and versioning.
- Public access block settings.
- The CloudFront distribution and default root object.
- The bucket policy restricted by the distribution ARN.
- Stack outputs for the bucket, distribution ID, and domain name.

Avoid reading every line. Explain why each security choice exists.

## 4. Deployment — 60 seconds

Show `deploy/deploy.sh`, then run:

```bash
AWS_REGION=af-south-1 ./deploy/deploy.sh
```

Explain that the script:

1. validates the template;
2. deploys the CloudFormation stack;
3. reads stack outputs;
4. synchronizes the website files to S3; and
5. invalidates the CloudFront cache.

Do not expose access keys or account details during the recording.

## 5. AWS Console proof — 60 seconds

In the AWS Management Console, show:

- the CloudFormation stack with a successful status;
- the private S3 bucket and uploaded site files;
- the CloudFront distribution with its domain and enabled status.

Open the CloudFront domain in a new tab to demonstrate the live website over HTTPS.

## 6. Closing — 30 seconds

> This project helped me apply AWS fundamentals beyond theory: cloud storage, content delivery, access control, infrastructure as code, and repeatable deployment. Future improvements could include a custom domain, an ACM certificate, deployment through GitHub Actions, and monitoring with CloudWatch.

Finish by showing the repository URL and inviting viewers to review the source code.

## Recording checklist

- Hide AWS account IDs, email addresses, credentials, and browser bookmarks.
- Increase terminal and editor font sizes.
- Test the deployment before recording.
- Confirm the CloudFront URL loads in a private browser window.
- Put the GitHub repository and live demo links in the video description.
