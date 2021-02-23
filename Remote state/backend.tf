terraform {
  backend "s3" {
    bucket  = "my-bucket-hibijibi"
    key     = "terraformstatefile"
    region  = "us-east-1"
    profile = "demo"
  }
}
