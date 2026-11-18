terraform {
  backend "s3" {
    bucket       = "pkry-app"
    region       = "ap-southeast-2"
    key          = "shanu/terraform.tfstate"
    encrypt      = true
    use_lockfile = true
  }
}