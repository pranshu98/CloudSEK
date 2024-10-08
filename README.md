
# Node.js AWS Terraform Deployment

This project uses Terraform to deploy a simple Node.js application on AWS using ECS Fargate and S3. The application will be accessible via a public endpoint.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Setup Instructions](#setup-instructions)
- [Deploying the Application](#deploying-the-application)
- [Accessing the Application](#accessing-the-application)
- [Cleanup](#cleanup)

## Prerequisites

1. **AWS Account**: Ensure you have an AWS account with the necessary permissions to create resources.
2. **Terraform**: Install Terraform on your local machine. You can follow the [official installation guide](https://www.terraform.io/downloads.html).
3. **GitHub Account**: Create a GitHub account if you don’t have one.
4. **GitHub Repository**: Create a new repository on GitHub to store this project.
5. **AWS CLI**: Install and configure the AWS CLI with your credentials. You can find setup instructions in the [AWS CLI documentation](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html).

## Setup Instructions

1. **Clone the Repository**:
   Open your terminal and clone the project repository:
   ```bash
   git clone https://github.com/yourusername/nodejs-aws-terraform.git
   cd nodejs-aws-terraform
   ```

2. **Configure Terraform Variables**:
   Edit the `terraform.tfvars` file to specify your AWS region and the subnet IDs where you want to deploy the application:
   ```hcl
   region = "us-east-1" # Adjust the region as necessary
   app_name = "your-app-name"
   subnets = ["subnet-abcde123", "subnet-fghij456"]  # Replace with your actual subnet IDs
   ```

3. **Set Up GitHub Secrets**:
   To securely store your AWS credentials, add the following secrets to your GitHub repository:
   - Go to your GitHub repository settings.
   - Under "Secrets and variables" > "Actions", click on "New repository secret".
   - Add the following secrets:
     - `AWS_ACCESS_KEY_ID`
     - `AWS_SECRET_ACCESS_KEY`

## Deploying the Application

To deploy the application, simply push your changes to the `main` branch. The GitHub Actions workflow will automatically trigger and run the Terraform commands to provision your infrastructure.

1. **Commit Your Changes**:
   ```bash
   git add .
   git commit -m "Initial deployment"
   ```

2. **Push to the Main Branch**:
   ```bash
   git push origin main
   ```

## Accessing the Application

Once the deployment is complete, you can access your Node.js application:

1. Go to the **AWS Management Console**.
2. Navigate to the **ECS** service.
3. Find your ECS cluster and service under the name you specified in `terraform.tfvars`.
4. Look for the public IP assigned to your ECS service to access the application.

You can also use the AWS CLI to retrieve the public IP of the running service.

## Cleanup

To remove the resources created by Terraform, run the following command in the terminal:

```bash
terraform destroy -state=terraform/terraform.tfstate terraform/
```

This will clean up all resources associated with your application.

