terraform {
    required_version = ">=0.12.13"
}

resource "aws_s3_bucket" "terraformS3Bucket"{
    bucket = "terraforms3bucket"
    acl = "private"

    tags = {
        Name = "terraforms3bucket"
        Environment = "OPS"
    }
}
