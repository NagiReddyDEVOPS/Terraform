provider "aws" {
  region     = "ap-south-1"
}

resource "aws_s3_bucket" "s3b" {
  bucket = "my-first-48444"

  tags = {
    Name        = "My-bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_object" "file123" {
  bucket = "my-first-48444"
  key    = "Multi"
  source = "C:\\Users\\lenovo\\Desktop\\Playbooks\\Multi.yml"
}

resource "null_resource" "multiplefiles" {
  provisioner "local-exec" {
    command = "aws s3 sync C:\\Users\\lenovo\\Desktop\\Resumes s3://my-first-48444"
}
}