![image](https://github.com/kiven9999/Webapp/assets/158525637/f6a4ab60-5467-4d1a-b0d1-5f44bc893afa)


# AWS Web Application Deployment with Terraform

This repository contains Terraform code to deploy a highly resilient, secure, and fault-tolerant web application on AWS using container orchestration (ECS). The application is stateless and uses only AWS services.

## Instructions for Use

### Prerequisites

1. **AWS Account:** Ensure you have an AWS account and the necessary permissions to create resources.

2. **Terraform Installation:** Install Terraform on your local machine. Follow the instructions [here](https://learn.hashicorp.com/tutorials/terraform/install-cli).

3. **AWS CLI:** Install and configure AWS CLI. Follow the instructions [here](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html).

### Setup Steps

1. **Fork this Repository:** Fork this repository to your GitHub account.

2. **Update AWS Credentials:**
   - Open `workflow.yml` and update the `aws_access_key` and `aws_secret_key` variables with your AWS access key and secret key.
   - opne variable on githubworkflows and pass the credentials

3. **Create an S3 Bucket for Backend State:**
   - Create an S3 bucket for storing the Terraform backend state file.
   - Update the `backend.tf` file with the correct S3 bucket name.

4. **Create ECR (Elastic Container Registry):**
   - Manually create an ECR repository in your AWS account.
   - Update the `workflow.yml` file with the correct ECR URI.
     
   **Github Workfow STEPs**
   
6. **Build Docker Image:**
   - Build a Docker image for the web application with 2 static pages.
   - Push the image to the ECR repository.

7. **Run Terraform:**
   - Execute the Terraform code to provision resources on AWS.
   - Run `terraform init`, `terraform plan`, and `terraform apply`.

8. **Access the Web Application:**
   - Once the Terraform deployment is successful, access the web application via the public load balancer.
   - navigate to your AWS account once deployment completess copy load balancer DNS and paste on your browser with /page1 or /page2 

### GitHub Actions Workflow

- The GitHub Actions workflow is configured to run on every push to the repository.
- Update the GitHub Actions workflow (`workflow.yml`) with your AWS credentials and ECR URI.
- Make sure to secure your secrets in GitHub by following [GitHub documentation](https://docs.github.com/en/actions/security-guides/encrypted-secrets).

### Local Testing

- Validate the Terraform code locally using `terraform validate`.
- Test the entire setup in your personal AWS account and verify the expected output.

## Additional Notes and improvements 

- If you encounter any issues or have questions, please open an issue in the repository.
- Contributions and improvements are welcome through pull requests will be happy to locate .
- could add multip AZs for faut tolerant ( JUST A POC at this point ) 

Happy Deploying!
