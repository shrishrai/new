variable "sql_server_name" {
    description = "The name of the SQL Server"
    type        = string
  
}
variable "resource_group_name" {
    description = "The name of the resource group"
    type        = string    
  
}

  
variable "sql_server_location" {
    description = "The Azure location where the SQL Server is created"
    type        = string  
}

variable "admin-login" {
    description = "The administrator login for SQL Server"
    type        = string  
}
variable "admin-password" {
    description = "The administrator login password for SQL Server"
    type        = string  
}