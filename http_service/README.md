
https://github.com/user-attachments/assets/84b48ad3-8a95-4933-b5e6-41a1efcb45d7
# S3 Bucket Content Listing using HTTP Service
#### This project provides an HTTP service that exposes an endpoint to list the contents of an S3 bucket. The service is implemented using Flask (Python) and Boto3(for aws interaction).

##### **Features -**
1) The service exposes the ec2_ip/list-bucket-content to return the contents of an S3 bucket.
Supports listing content at different path levels within the bucket.
2) If no path is specified, the top-level content of the bucket is returned.
Returns results in JSON format.

- Root content of the bucket:
`GET http://IP:PORT/list-bucket-content`
    - Response:
`
{
  "content": ["dir1", "dir2", "file1", "file2"]
}
`
- Content within dir2:
`GET http://IP:PORT/list-bucket-content/dir2`
     - Response:
`
{
  "content": ["file1", "file2"]
}
`
- Content of a non-existing path:
`GET http://IP:PORT/list-bucket-content/abc`
    - Response -
`
{
  "error": "The specified path 'abc' does not exist in the bucket."
}
`

---

##### **Setup Instructions**
Prerequisites:
1) AWS Account with access to S3 (Done in terraform by giving role).
2) AWS CLI configured with account password.
3) Python 3.x installed along with pip package manager.
Flask and Boto3 libraries installed.

---

##### **Deployment to AWS using Terraform:**
* The service is designed to be deployed on an EC2 instance. The necessary AWS resources (IAM role, ec2, security group) are provisioned using Terraform.

- Run the following Terraform commands to deploy:
    - terraform init
    - terraform apply

After Terraform completes, it will output the public IP of the EC2 instance. You can access the service via this IP on port 5000(already given url to copy paste in terraform output)
       ` http://<EC2_Public_IP>:5000/list-bucket-content`

---

**Terraform Resources created:**
1) IAM Role: Provides read-only access to the S3 bucket(given in terraform).
2) EC2 Instance: Deploys the Flask app with all necessary dependencies.
3) Security Group: Allows HTTP (port 5000) and SSH (port 22) access to the EC2 instance.

---

**Error Handling:**
The service gracefully handles invalid or non-existing paths by returning a 404 error with an appropriate message.
In case of unexpected errors, a 500 internal server error is returned.

---

**Bonus Features:**
The service is designed to support easy extension for HTTPS and additional security measures.

---


**Challenges & Assumptions:**
1) While performing faced error of no access so IAM roles and policies are configured for read-only access to S3 to tackle the problem.

---

**Conclusion:**
This service allows for easy retrieval of S3 bucket contents in a specified path, supporting both root-level and nested directories. The project leverages AWS infrastructure with Terraform for deployment and Flask for the HTTP service.

---
