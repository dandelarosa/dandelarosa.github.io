---
layout: post
title: "Course Recap: Developing on AWS"
---

Last month I took a course called [Developing on AWS](https://aws.amazon.com/training/classroom/developing-on-aws/). It was an intermediate level course on using Amazon Web Services with live (albeit remote) lectures and labs. Instead of going over everything that was taught during that course, I’ll go over three topics explored the course.

## Amazon SDK

I’ll admit, most of my interactions with Amazon Web Services have been through the AWS Management Console. However, AWS provides an interface to using the services programmatically, providing features that aren’t available on the web, and it is available in several programming languages. The AWS SDK for Python is a library called Boto3 and I used that in the labs to upload files to S3, save records on DynamoDB, and send messages to Amazon SNS.

## Serverless Programming

Serverless is a trend picking up steam, which was something I noticed when I was interviewing for jobs two years ago. Instead of running a server full-time, your code would only run when a request is actually made. That way you won’t pay for the time your application sits idly.

On AWS this is achieved by using AWS Lambda and Amazon API Gateway. On AWS Lambda you can write functions that can be fired on demand. You can use Lambda functions to respond to HTTP requests or to execute long-running processes (up to 15 minutes) in the background. API Gateway acts the surface layer for routing requests. With this service you can configure a complete API, assigning a Lambda function to each path and action.

## Misc. AWS Services

The products provided by Amazon Web Services aren’t limited to computing and storage. AWS is ambitious and they try to come up with a solution for every use case they can conceive.

One of those services is Amazon Simple Queue Service, which allows you to store requests to process at a later time. It’s one way to decouple a user placing an order from all things that need to be done behind the scenes to fulfill that order. It could also be used as a way of sharing information between microservices, which are otherwise isolated from each other by design. SQS could be used for solving some of the architectural problems my team is facing at work.

The last lab in the course had students build an end-to-end application using the various services provided by AWS. Instead of importing an authentication system or writing one from scratch, we used Amazon Cognito for managing user accounts and logins. We then used Amazon Polly to convert text notes into speech. Amazon Web Services is a powerful set of tools and it can be used to replace much of your application’s infrastructure.
