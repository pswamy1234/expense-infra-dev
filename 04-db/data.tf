data "aws_ssm_parameter" "db_sg_id" {
  name = "/${var.project_name}/${var.environment}/db_sg_id"
}

data "aws_ssm_parameter" "db_subnet_group_name" {
  name = "/${var.project_name}/${var.environment}/db_subnet_group_name"
}

data "aws_ssm_parameter" "private_subnet_ids" {
  name = "/${var.project_name}/${var.environment}/private_subnet_ids"
}
