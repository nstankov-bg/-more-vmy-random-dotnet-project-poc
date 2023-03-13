
variable "aws_access_key" {
  type    = string
  default = "${env("AWS_ACCESS_KEY_ID")}"
}

variable "aws_region" {
  type    = string
  default = "eu-central-1"
}

variable "aws_secret_key" {
  type    = string
  default = "${env("AWS_SECRET_ACCESS_KEY")}"
}

packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.1"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

data "amazon-ami" "main" {
  access_key = "${var.aws_access_key}"
  filters = {
    name                = "amzn2-ami-kernel-5.10-hvm-2.0.20230307.0-x86_64-gp2"
    virtualization-type = "hvm"
  }
  most_recent = true
  owners      = ["amazon"]
  region      = "${var.aws_region}"
  secret_key  = "${var.aws_secret_key}"
}

locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

source "amazon-ebs" "main" {
  access_key    = "${var.aws_access_key}"
  ami_name      = "aws-linux2-docker-octopus-terraform ${local.timestamp} DEV"
  instance_type = "t3.medium"
  region        = "${var.aws_region}"
  secret_key    = "${var.aws_secret_key}"
  source_ami    = "${data.amazon-ami.main.id}"
  ssh_username  = "ec2-user"
}

build {
  sources = ["source.amazon-ebs.main"]
  provisioner "file" {
    source      = "./docker/octopus"
    destination = "/home/ec2-user/octopus"
  }
  provisioner "shell" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y docker",
      "sudo systemctl start docker",
      "sudo systemctl enable docker",
      "sudo usermod -aG docker ec2-user",
      "sudo amazon-linux-extras install epel -y",
      "sudo yum install -y python-pip",
      "sudo pip install awscli",
      "sudo curl -L https://releases.hashicorp.com/terraform/1.3.9/terraform_1.3.9_linux_amd64.zip -o /tmp/terraform.zip",
      "sudo unzip -d /usr/local/bin /tmp/terraform.zip",
      "sudo chmod +x /usr/local/bin/terraform",
      "sudo rm -f /tmp/terraform.zip",
      "sudo yum install -y yum-utils device-mapper-persistent-data lvm2",
      "sudo amazon-linux-extras install docker -y",
      "sudo systemctl start docker",
      "sudo systemctl enable docker",
      "sudo curl -L https://github.com/docker/compose/releases/download/v2.17.0-rc.1/docker-compose-linux-x86_64 -o /usr/bin/docker-compose",
      "sudo chmod +x /usr/bin/docker-compose",
      "sudo docker-compose --version",
      "cd /home/ec2-user/octopus",
      "sudo docker-compose up -d"
    ]
  }

}
