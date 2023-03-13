# additional_eni_ids	Map of ENI to EIP
# alarm	CloudWatch Alarm ID
# arn	ARN of the instance
# ebs_ids	IDs of EBSs
# id	Disambiguated ID of the instance
# instance_profile	Name of the instance's profile (either built or supplied)
# name	Instance name
# primary_network_interface_id	ID of the instance's primary network interface
# private_dns	Private DNS of instance
# private_ip	Private IP of instance
# public_dns	Public DNS of instance (or DNS of EIP)
# public_ip	Public IP of instance (or EIP)
# role	Name of AWS IAM Role associated with the instance
# role_arn	ARN of AWS IAM Role associated with the instance
# security_group_arn	EC2 instance Security Group ARN
# security_group_id	EC2 instance Security Group ID
# security_group_ids	IDs on the AWS Security Groups associated with the instance
# security_group_name	EC2 instance Security Group name
# ssh_key_pair	Name of the SSH key pair provisioned on the instance

output "arn" {
  value = module.worker_instance.arn
}

output "id" {
  value = module.worker_instance.id
}

output "private_dns" {
  value = module.worker_instance.private_dns
}

output "private_ip" {
  value = module.worker_instance.private_ip
}

output "public_dns" {
  value = module.worker_instance.public_dns
}

output "public_ip" {
  value = module.worker_instance.public_ip
}

output "security_group_id" {
  value = module.worker_instance.security_group_id
}

output "security_group_ids" {
  value = module.worker_instance.security_group_ids
}

output "security_group_name" {
  value = module.worker_instance.security_group_name
}

output "ssh_key_pair" {
  value = module.worker_instance.ssh_key_pair
}

output "ebs_ids" {
  value = module.worker_instance.ebs_ids
}

