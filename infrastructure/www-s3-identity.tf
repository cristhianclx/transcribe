resource "aws_cloudfront_origin_access_identity" "s3_identity" {
  comment = local.name
}

data "aws_iam_policy_document" "s3_identity" {
  statement {
    actions = ["s3:GetObject"]
    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.s3_identity.iam_arn]
    }
    resources = ["${aws_s3_bucket.s3.arn}/*"]
  }
  statement {
    actions = ["s3:ListBucket"]
    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.s3_identity.iam_arn]
    }
    resources = [aws_s3_bucket.s3.arn]
  }
}

resource "aws_s3_bucket_policy" "s3_identity" {
  bucket = aws_s3_bucket.s3.id
  policy = data.aws_iam_policy_document.s3_identity.json
}
