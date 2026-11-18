terraform {
  backend "s3" {
    region       = "ap-southeast-2"
    bucket       = "pkry-app"
    key          = "shanu/terraform.tfstate"
    encrypt      = true
    use_lockfile = true

  }
}

