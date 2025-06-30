terraform {
  required_version = ">=1.9.5"

  backend "s3" {
    bucket               = "infrastructure.demo.pe"
    key                  = "transcribe.demo.pe"
    encrypt              = "true"
    region               = "sa-east-1"
    workspace_key_prefix = "tf"
  }
}
