terraform{
backend "s3" {
    bucket       = "unique-bucket-name"
    key          = "folder in the bucket"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
 }
}

