terraform {
  backend "s3" {
    bucket         = "my-bucket-ar10"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}