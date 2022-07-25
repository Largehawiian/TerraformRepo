terraform {
    required_version = ">=0.12.13"
}

resource "aws_s3_bucket" "terraformS3Bucket"{
    bucket = "terraforms3bucketjjackson"
    acl = "private"

    tags = {
        Name = "terraforms3bucketjjackson"
        Environment = "OPS"
    }
}
