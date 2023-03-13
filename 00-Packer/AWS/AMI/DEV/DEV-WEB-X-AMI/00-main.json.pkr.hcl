packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.1"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

variable "region" {
  type    = string
  default = "eu-central-1"
}

locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}

source "amazon-ebs" "firstrun-windows" {
  ami_name      = "packer-windows-demo-${local.timestamp} DEV"
  communicator  = "winrm"
  instance_type = "t3.xlarge"
  region        = "${var.region}"
  source_ami_filter {
    filters = {
      name                = "Windows_Server-2022-English-Full-Base*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["amazon"]
  }
  user_data_file = "./bootstrap_win.txt"
  winrm_password = "SuperS3cr3t!!!!"
  winrm_username = "Administrator"
}

build {
  name    = "Packer-Windows-Demo"
  sources = ["source.amazon-ebs.firstrun-windows"]

  provisioner "powershell" {
    script = "./ISS.ps1"
  }
  // provisioner "powershell" {
  //   script = "./Octopus.ps1"
  // }

  provisioner "windows-restart" {}
}
