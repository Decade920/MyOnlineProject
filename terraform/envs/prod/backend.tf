terraform {
  backend "cos" {
    region = "ap-guangzhou"
    bucket = "my-terraform-1253525130"
    prefix = "terraform/state/prod"
  }
}
