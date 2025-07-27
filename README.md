# Infrastructure deployment exercise

Using Terraform, automate the build of the following application in AWS. For the purposes of this challenge, use any Linux based AMI id for the two EC2 instances and simply show how they would be provisioned with the connection details for the RDS cluster.

![diagram](./images/diagram.png)

## Implementation

This Terraform configuration creates:
- Application Load Balancer with SSL/TLS termination
- Auto Scaling Group with 2-4 EC2 instances in private subnets
- RDS Aurora MySQL cluster with 2 instances
- Security groups with proper access controls
- VPC with public/private subnets and NAT gateway
- Secrets Manager for database credentials
- CloudWatch logging and monitoring
- S3 bucket for ALB access logs

## Assumptions and Additions

1. **AMI Selection**: Uses latest Amazon Linux 2 AMI (dynamically fetched)
2. **Database**: Aurora MySQL cluster for high availability
3. **Security**: Least privilege security groups + Secrets Manager
4. **Auto Scaling**: 2-4 instances with CPU-based scaling policies
5. **SSL/TLS**: Optional HTTPS with ACM certificate
6. **Logging**: ALB access logs to S3, VPC Flow Logs to CloudWatch
7. **Monitoring**: CloudWatch alarms for CPU and budget alerts

## Usage

```bash
terraform init
terraform plan
terraform apply

# For HTTPS (optional)
terraform apply -var="domain_name=example.com"
```

## How would a future application obtain the load balancer's DNS name?

1. **Terraform Output**: Use `terraform output load_balancer_dns_name`
2. **AWS CLI**: `aws elbv2 describe-load-balancers --names cint-code-test`
3. **Service Discovery**: Store in Parameter Store/Secrets Manager
4. **DNS Alias**: Create Route53 alias record pointing to the ALB
5. **Environment Variables**: Pass as env var in container/application config

## CD Pipeline Considerations

1. **State Management**:
   - Use remote state (S3 + DynamoDB for locking)
   - Separate state files per environment

2. **Security**:
   - Use IAM roles, not access keys
   - Store sensitive outputs in AWS Secrets Manager
   - Enable CloudTrail for audit logging

3. **Safety**:
   - Implement `terraform plan` review step
   - Use workspaces or separate directories per environment
   - Enable deletion protection on critical resources
   - Implement blue/green or rolling deployments

4. **Validation**:
   - Run `terraform validate` and `terraform fmt`
   - Use tools like tfsec, checkov for security scanning
   - Implement automated testing of infrastructure

5. **Rollback Strategy**:
   - Tag infrastructure versions
   - Maintain previous Terraform state backups
   - Implement database migration rollback procedures

## FinOps Considerations

1. **Cost Monitoring**:
   - AWS Budget with 80% threshold alerts
   - CloudWatch alarms for resource utilization
   - Cost allocation tags (project, environment, cost-center)

2. **Resource Optimization**:
   - t3.micro instances for cost efficiency
   - Configurable backup retention (default: 1 day)
   - Auto-stop tags for automated shutdown
   - Single NAT Gateway (multi-AZ for production)

3. **Right-sizing**:
   - Monitor CPU/memory utilization
   - Use Spot instances for non-critical workloads
   - Consider Reserved Instances for predictable workloads
   - Aurora Serverless for variable workloads