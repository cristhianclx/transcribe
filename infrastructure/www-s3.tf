resource "aws_s3_bucket" "s3" {
  bucket        = var.name
  force_destroy = true
}

resource "aws_s3_bucket_ownership_controls" "s3" {
  bucket = aws_s3_bucket.s3.id
  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_s3_bucket_acl" "s3" {
  bucket = aws_s3_bucket.s3.id
  acl    = "private"
  depends_on = [
    aws_s3_bucket.s3,
    aws_s3_bucket_ownership_controls.s3,
  ]
}

resource "aws_s3_bucket_versioning" "s3" {
  bucket = aws_s3_bucket.s3.id
  versioning_configuration {
    status = "Disabled"
  }
  depends_on = [
    aws_s3_bucket.s3,
  ]
}

resource "aws_s3_bucket_public_access_block" "s3" {
  bucket                  = aws_s3_bucket.s3.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
  depends_on = [
    aws_s3_bucket.s3,
  ]
}

resource "aws_s3_bucket_cors_configuration" "s3" {
  bucket = aws_s3_bucket.s3.id
  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "HEAD"]
    allowed_origins = ["*"]
    max_age_seconds = 3000
  }
  depends_on = [
    aws_s3_bucket.s3,
  ]
}
