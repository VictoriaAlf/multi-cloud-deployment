variable "bucket_name" {
  description = "The name of the storage bucket for the function"
  type        = string
}

variable "function_name" {
  description = "The name of the Cloud Function"
  type        = string
}

variable "runtime" {
  description = "The runtime environment for the Cloud Function"
  type        = string
  default     = "python39"
}

variable "region" {
  description = "The region to deploy the Cloud Function"
  type        = string
}

variable "source_archive_object" {
  description = "The source archive object for the Cloud Function"
  type        = string
}

variable "entry_point" {
  description = "The entry point of the Cloud Function"
  type        = string
}

variable "environment_variables" {
  description = "A map of environment variables to set for the Cloud Function"
  type        = map(string)
  default     = {}
}

variable "description" {
  description = "Lambda function objective"
  type = string
  default = ""
}