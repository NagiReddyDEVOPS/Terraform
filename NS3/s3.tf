provider "aws" {
  region = "ap-south-1"
}

resource "aws_s3_bucket" "s3b" {
  bucket = "my-tf-test-04-07-2023"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_object" "upload" {
  bucket = "my-tf-test-04-07-2023"
  key    = "maven"
  source = "C:\\Users\\lenovo\\Desktop\\Vtech\\Maven.docx"
}

resource "null_resource" "multiple" {
  provisioner "local-exec" {
    command = "aws s3 sync C:\\Users\\lenovo\\Desktop\\Resumes s3://my-tf-test-04-07-2023"
  }
}