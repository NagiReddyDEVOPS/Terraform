provider "aws" {
  region = "ap-south-1"
}

resource "aws_s3_bucket" "bucket" {
  bucket = "my-tf-test-bucket-484"

  tags = {
    Name        = "vtechdevops123"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_object" "object" {
  bucket = "my-tf-test-bucket-484"
  key    = "reh"
  source = "C:\\Users\\lenovo\\Desktop\\reh.ppk"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5("C:\\Users\\lenovo\\Desktop\\reh.ppk")
}