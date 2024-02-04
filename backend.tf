terraform {
  backend "s3" {
    bucket     = "webapp-task-dxc-state-file"
    key        = "webapp-task/terraform.tfstate"
    region     = "us-east-2"
  }
}