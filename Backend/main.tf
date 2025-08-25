# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# Create an S3 bucket that will serve as the backend for Terraform state
resource "aws_s3_bucket" "terraform_state" {
  bucket = "my-terraform-state-bucket-adn1" # Change to a unique bucket name

  lifecycle {
    prevent_destroy = false
  }
}
  # Add versioning using the recommended resource
  resource "aws_s3_bucket_versioning" "terraform_state_versioning" {
    bucket = aws_s3_bucket.terraform_state.id
    versioning_configuration {
      status = "Enabled"
    }
  }

resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name         = "terraform-eks-state-lock-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

}