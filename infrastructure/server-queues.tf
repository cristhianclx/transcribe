resource "aws_sqs_queue" "transcriptions" {
  name = "${local.server}-transcriptions.fifo"

  fifo_queue                  = true
  content_based_deduplication = false

  visibility_timeout_seconds = 60
  message_retention_seconds  = 86400
  delay_seconds              = 0
  max_message_size           = 262144
  receive_wait_time_seconds  = 0
}
