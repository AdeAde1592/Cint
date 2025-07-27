locals {
  tags = {
    project     = var.name
    environment = "dev"
    cost-center = "engineering"
    auto-stop   = "true"
  }
}