# Serverless_Jenkins_Terraform
Jenkins is a popular open-source automation server that enables developers around the world to reliably build, test, and deploy their software. Jenkins uses a controller-agent architecture in which the controller is responsible for serving the web UI, stores the configurations and related data on disk, and delegates the jobs to the worker agents that run these jobs as their primary responsibility.

Amazon Elastic Container Service (Amazon ECS) is a fully managed container orchestration service, and has been a popular choice to deploy a highly available, fault tolerant, and scalable Jenkins environment. Traditionally, the Amazon Elastic Compute Cloud (Amazon EC2) launch type was the preferred choice, with Amazon Elastic Block Store (Amazon EBS) as the storage for the configurations and data. That changed with the introduction of AWS Fargate support for Amazon EFS.

The objective of this post is to walk you through how to set up a completely serverless Jenkins environment on AWS Fargate using Terraform.

Overview of the solution
The following diagram illustrates the solution architecture.