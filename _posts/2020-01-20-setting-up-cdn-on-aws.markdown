---
layout: post
title: "Setting Up a CDN on CloudFront"
---

A content delivery network, or CDN, is a useful method of delivering web content to your users. They are designed to solve several of a website's perfomance issues, such as being able serve multiple users simultaneously.

Websites can utilize multiple CDNs for different purposes. This blog runs on GitHub Pages, which uses its own CDN to send the page's markup and stylesheets to the browser. Moreover, I've set up a separate CDN for hosting the images that appear on this blog. There are several reasons why I'm hosting images on a different CDN:

- Different CDN solutions may be optimized for hosting static content as opposed to a server running business logic.
- A different CDN solution may be optimized for hosting images, which are often larger than plaintext files.
- By hosting images separately I can update the images independently without having to update the blog's source code; and repository checkout times are kept to a minimum since images are not checked into the Git history.

In this post I'll show you how I set up a CDN (almost) entirely on AWS. The only component that is outside of AWS is my domain name, which was purchased through a third-party provider.

# 1. Create a Bucket on S3

Amazon's Simple Storage Service, also known as S3, is a service that can be used for uploading files and making them downloadable or otherwise accessible on the Internet. In S3 buckets are containers that hold files, and they also have their own access controls and other configurations.

Enter the S3 web console by going to [s3.console.aws.amazon.com](https://s3.console.aws.amazon.com/) and logging in with your account. Once you've authenticated tap the "Create Bucket" button, which will bring up a menu. Decide on a name for your bucket (make sure it hasn't been taken yet!) and tap "Create".

![alt text](https://cdn-blog.dandelarosa.net/2020/01/20/setting-up-domain-on-aws/createbucket-1.png "Creating a bucket on S3")

After being created, the bucket will need to be configured so that its contents can be publicly accessible. On the list of buckets select the bucket you've created. Click on the "Permissions" tab.

First, you'll want to unblock public access. Tap the "Block public access" button, and then tap the "Edit" button on the diagram below. Uncheck all of the buckets and then tap "Save".

![alt text](https://cdn-blog.dandelarosa.net/2020/01/20/setting-up-domain-on-aws/publicaccess-1.png "Make sure all 'Block public access' boxes are unselected.")

Next, you'll want to edit the bucket policy. Tap the "Bucket Policy" button, and enter the following into the text box below:

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadForGetBucketObjects",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::BUCKETNAME/*"
        }
    ]
}
```

Don't forget to replace `BUCKETNAME` with the actual name of the bucket.

# 2. Set Up HTTPS For Your Subdomain

- Log into the AWS Certificate Manager at [console.aws.amazon.com/acm](https://console.aws.amazon.com/acm).
- Tap on "Request a certificate".
- When asked for the type of certificate, select "Request a public certificate".
- Enter in the domains to be associated with the certificate. CloudFront only allows one HTTPS certificate per distribution so the certificate should list all of the domain names it intends to support. There are legitimate reasons to add multiple domains, such as if you're hosting on both `www.example.com` and `example.com`.
- When asked to select a validation, choose "DNS validation" if your domain records are managed by Route 53. Later, in "Step 5: Validation", there is a button you can press to create the validation records for you.

# 3. Create CloudFront distribution

- Log into the AWS CloudFront Management Console at [console.aws.amazon.com/cloudfront](https://console.aws.amazon.com/cloudfront)
- Tap on "Create Distribution".
- When asked to select a delivery method, select "Web".
- Enter the Origin Domain Name (select your S3 bucket as the origin)
- Scroll down to SSL Certificate and select Custom SSL Certificate. In the search box,  type in the identifier corresponding to certificate you want to use.
- When tapping Alternate Domain Names (CNAMEs) and enter the domain name(s) where you want to host the CDN.
- Tap "Create Distribution".
- Make note of the distribution's domain name (it should look something like d111111abcdef8.cloudfront.net). It will need to be copied in the next step.

# 4. Link Your Custom Domain to CloudFront

- Log into the Route 53 Management Console at [console.aws.amazon.com/route53](https://console.aws.amazon.com/route53)
- Go to the "Hosted Zones" section.
- Browse to your hosted zone.
- Create a record set to connect your subdomain to your CloudFront distribution.
  - Enter in your custom subdomain.
  - Select Type A.
  - Set "Alias" to Yes.
  - Enter the CloudFront distribution's domain name into the "Alias Target" field.

# 5. Upload Your Files

You can upload your files by using the web console, [the AWS CLI](https://aws.amazon.com/cli/), or a third-party app like [Transmit](https://panic.com/transmit/). If the process was completed successfully, you should be able to view your files from the web browser. The URL for accessing the file should be structured like the following:

```
https://(your custom domain)/(path to the file within your S3 bucket)
```
