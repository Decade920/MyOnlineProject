terraform {
  required_providers {
    tencentcloud = {
        source = "tencentcloudstack/tencentcloud"
        version = "1.83.31"
    }
  }
}

provider "tencentcloud" {
    region = "ap-guangzhou"
}