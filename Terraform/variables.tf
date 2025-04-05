variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
  default     = "East US"
}

variable "app_service_plan_sku" {
  description = "The pricing SKU for the Service Plan"
  type        = string
  default     = "B1"  # Adjust based on your needs (e.g., B1, S1, P1v2)
}