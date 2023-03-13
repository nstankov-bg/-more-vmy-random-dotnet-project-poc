module "worker_instance" {
  source                      = "cloudposse/ec2-instance/aws"
  vpc_id                      = var.vpc_id
  subnet                      = var.subnet
  ssh_key_pair                = var.ssh_key_pair
  instance_type               = "t3.medium"
  associate_public_ip_address = true
  name                        = "worker-01"
  root_volume_size            = 100 #Image is 30GB
  namespace                   = "dynamo"
  stage                       = "prod"
  ami                         = var.ami_id
  ami_owner                   = var.ami_owner
  ebs_volume_count            = 2
  security_group_rules = [
    {
      type        = "egress"
      from_port   = 0
      to_port     = 65535
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      type        = "ingress"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      type        = "ingress"
      from_port   = 11111
      to_port     = 11111
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      type        = "ingress"
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      type        = "ingress"
      from_port   = 3389
      to_port     = 3389
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      type        = "ingress"
      from_port   = 10933
      to_port     = 10933
      protocol    = "tcp"
      cidr_blocks = ["172.31.0.0/16"]
    }
  ]
}
