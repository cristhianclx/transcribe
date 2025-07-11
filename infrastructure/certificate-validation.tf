resource "aws_route53_record" "validation__2025" {
  zone_id = data.aws_route53_zone.main.zone_id

  for_each = {
    for dvo in aws_acm_certificate.main__2025.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  type            = each.value.type
  records         = [each.value.record]
  ttl             = 60
}

resource "aws_acm_certificate_validation" "main__2025" {
  certificate_arn         = aws_acm_certificate.main__2025.arn
  validation_record_fqdns = [for record in aws_route53_record.validation__2025 : record.fqdn]
}
