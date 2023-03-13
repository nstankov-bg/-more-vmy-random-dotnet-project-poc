module "worker_instance" {
  source                      = "cloudposse/ec2-instance/aws"
  vpc_id                      = var.vpc_id
  subnet                      = var.subnet
  ssh_key_pair                = var.ssh_key_pair
  instance_type               = "t3.medium"
  root_volume_size            = 100 #Image is 30GB
  associate_public_ip_address = true
  name                        = "server-02"
  namespace                   = "dynamo"
  stage                       = "prod"
  ami                         = var.ami_id
  ami_owner                   = var.ami_owner
  ebs_volume_count            = 2
  # The first rule allows egress traffic to any port, meaning that outbound traffic is not restricted by any port or protocol.
  # The second rule allows incoming HTTP traffic on port 80 using the TCP protocol. This is the default port used for unencrypted web traffic.
  # The third rule allows incoming HTTPS traffic on port 443 using the TCP protocol. This is the default port used for encrypted web traffic.
  # The forth rule allows incoming traffic on port 8172 using the TCP protocol. This port is used for remote management of IIS using the IIS Manager tool.
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
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      type        = "ingress"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      type        = "ingress"
      from_port   = 8172
      to_port     = 8172
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
