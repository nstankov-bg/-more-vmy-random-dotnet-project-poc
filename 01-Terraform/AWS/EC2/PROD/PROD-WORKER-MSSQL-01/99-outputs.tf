# hostname	DNS host name of the instance
# instance_address	Address of the instance
# instance_arn	ARN of the instance
# instance_endpoint	DNS Endpoint of the instance
# instance_id	ID of the instance
# option_group_id	ID of the Option Group
# parameter_group_id	ID of the Parameter Group
# resource_id	The RDS Resource ID of this instance.
# security_group_id	ID of the Security Group
# subnet_group_id	ID of the created Subnet Group

output "hostname" {
    value       = module.rds_instance.hostname
    description = "DNS host name of the instance"
}

output "instance_address" {
    value       = module.rds_instance.instance_address
    description = "Address of the instance"
}

output "instance_arn" {
    value       = module.rds_instance.instance_arn
    description = "ARN of the instance"
}

output "instance_endpoint" {
    value       = module.rds_instance.instance_endpoint
    description = "DNS Endpoint of the instance"
}

output "instance_id" {
    value       = module.rds_instance.instance_id
    description = "ID of the instance"
}

output "option_group_id" {
    value       = module.rds_instance.option_group_id
    description = "ID of the Option Group"
}

output "parameter_group_id" {
    value       = module.rds_instance.parameter_group_id
    description = "ID of the Parameter Group"
}

output "resource_id" {
    value       = module.rds_instance.resource_id
    description = "The RDS Resource ID of this instance."
}

output "security_group_id" {
    value       = module.rds_instance.security_group_id
    description = "ID of the Security Group"
}

output "subnet_group_id" {
    value       = module.rds_instance.subnet_group_id
    description = "ID of the created Subnet Group"
}

# Path: 01-Terraform/DEV/DEV-WORKER-MSSQL-01/99-outputs.tf
