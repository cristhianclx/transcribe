resource "aws_acm_certificate" "main__2025" {
  domain_name               = var.name
  subject_alternative_names = ["*.${var.name}"]

  validation_method = "DNS"

  tags = {
    Name = var.name
  }

  lifecycle {
    create_before_destroy = true
  }
}
