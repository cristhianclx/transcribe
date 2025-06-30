locals {
  website_s3_origin_id = "${local.name}-s3"
}

resource "aws_cloudfront_distribution" "website" {
  aliases = [var.name]
  comment = local.name

  default_cache_behavior {
    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD", "OPTIONS"]
    compress        = true
    default_ttl     = 0
    forwarded_values {
      query_string = false
      headers = [
        "Access-Control-Request-Headers",
        "Access-Control-Request-Method",
        "Origin",
      ]
      cookies {
        forward = "none"
      }
    }
    min_ttl                = 0
    max_ttl                = 0
    target_origin_id       = local.website_s3_origin_id
    viewer_protocol_policy = "redirect-to-https"
  }

  custom_error_response {
    error_code            = "404"
    error_caching_min_ttl = "0"
    response_code         = "200"
    response_page_path    = "/404/index.html"
  }

  default_root_object = "index.html"
  enabled             = true
  http_version        = "http2"
  is_ipv6_enabled     = true

  origin {
    domain_name = aws_s3_bucket.s3.bucket_regional_domain_name
    origin_id   = local.website_s3_origin_id
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.s3_identity.cloudfront_access_identity_path
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.main__2024.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  wait_for_deployment = true
  depends_on = [
    aws_s3_bucket.s3,
  ]
}
