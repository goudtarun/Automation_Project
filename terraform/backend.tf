terraform{
backend "s3" {
    bucket       = "tf-state-dr1"
    key          = "tf-state-dr1/Devops-Project-20thfeb/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
 }
}

