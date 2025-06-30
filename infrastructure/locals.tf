locals {
  name   = replace(var.name, ".", "-")
  server = replace(var.server, ".", "-")
}
