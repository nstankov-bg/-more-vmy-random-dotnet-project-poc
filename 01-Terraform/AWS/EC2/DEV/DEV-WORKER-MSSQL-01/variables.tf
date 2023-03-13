variable "namespace" {
  description = "The namespace used for naming resources"
  type        = string
}

variable "stage" {
  description = "The stage used for naming resources"
  type        = string
}

variable "name" {
  description = "The name of the RDS instance"
  type        = string
}

variable "security_group_ids" {
  description = "A list of security group IDs to associate with the RDS instance"
  type        = list(string)
}

variable "ca_cert_identifier" {
  description = "The identifier of the CA certificate for the RDS instance"
  type        = string
}

variable "allowed_cidr_blocks" {
  description = "A list of CIDR blocks to allow access to the RDS instance"
  type        = list(string)
}

variable "database_user" {
  description = "The username for the RDS instance database"
  type        = string
}

variable "database_password" {
  description = "The password for the RDS instance database"
  type        = string
}

variable "database_port" {
  description = "The port to use for the RDS instance database"
  type        = number
}

variable "multi_az" {
  description = "Whether to create the RDS instance as a multi-AZ deployment"
  type        = bool
}

variable "instance_class" {
  description = "The instance class for the RDS instance"
  type        = string
}

variable "db_parameter_group" {
  description = "The name of the DB parameter group to associate with the RDS instance"
  type        = string
}

variable "storage_type" {
  description = "The type of storage to use for the RDS instance"
  type        = string
}

variable "allocated_storage" {
  description = "The amount of storage to allocate for the RDS instance"
  type        = number
}

variable "storage_encrypted" {
  description = "Whether to enable encryption for the RDS instance storage"
  type        = bool
}

variable "engine" {
  description = "The database engine for the RDS instance"
  type        = string
}

variable "engine_version" {
  description = "The version of the database engine for the RDS instance"
  type        = string
}

variable "subnet_ids" {
  description = "A list of subnet IDs to use for the RDS instance"
  type        = list(string)
}

variable "vpc_id" {
  description = "The ID of the VPC to use for the RDS instance"
  type        = string
}

variable "auto_minor_version_upgrade" {
  description = "Whether to enable automatic minor version upgrades for the RDS instance"
  type        = bool
}

variable "allow_major_version_upgrade" {
  description = "Whether to allow major version upgrades for the RDS instance"
  type        = bool
}

variable "apply_immediately" {
  description = "Whether changes should be applied immediately to the RDS instance"
  type        = bool
}

variable "maintenance_window" {
  description = "The maintenance window for the RDS instance"
  type        = string
}

variable "skip_final_snapshot" {
  description = "Whether to skip the final snapshot for the RDS instance when it is deleted"
  type        = bool
}

variable "copy_tags_to_snapshot" {
  description = "Whether to copy tags to the final snapshot of the RDS instance"
  type        = bool
}

variable "backup_retention_period" {
  description = "The backup retention period for the RDS instance"
  type        = number
}

variable "backup_window" {
  description = "The backup window for the RDS instance"
  type        = string
}
