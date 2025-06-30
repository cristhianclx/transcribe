output "name" {
  value = var.name
}
output "server" {
  value = var.server
}
output "certificate_arn__2025" {
  value = aws_acm_certificate.main__2025.arn
}
output "certificate_validations__2025" {
  value = [
    for dvo in aws_acm_certificate.main__2025.domain_validation_options : "${dvo.domain_name} => ${dvo.resource_record_type} : ${dvo.resource_record_name} -> ${dvo.resource_record_value}"
  ]
}
output "transcriptions" {
  value = aws_sqs_queue.transcriptions.id
}
output "transcriptions_arn" {
  value = aws_sqs_queue.transcriptions.arn
}
