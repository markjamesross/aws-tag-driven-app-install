variable "tags" {
  description = "Tags to apply to resources"
  type        = map(any)
  default = {
    Environment = "App-Install-Event-Driven-Test"
  }
}

variable "ssm_document_install" {
  description = "Name of SSM document to install app"
  type        = string
  default     = "event-driven-install"
}

variable "ssm_document_uninstall" {
  description = "Name of SSM document to install app"
  type        = string
  default     = "event-driven-uninstall"
}

variable "app_tag_key" {
  description = "Tag key to use to drive install of application"
  type        = string
  default     = "install-app"
}

variable "app_tag_install_value" {
  description = "Tag value to use to drive install of application.  Any other value or removal of the key will result in an uninstall"
  type        = string
  default     = "true"
}