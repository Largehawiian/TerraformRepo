terraform {
    required_version = ">=0.12.13"
}

resource "aws_s3_bucket" "terraformS3Bucket"{
    bucket = "terraformS3Bucket"
    acl = "private"

    tags = {
        Name = "terraformS3Bucket"
        Environment = "OPS"
    }
}
