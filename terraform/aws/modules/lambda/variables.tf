variable "lambda_name" {
  description = "The name of the Lambda function"
  type        = string
}

variable "lambda_handler" {
  description = "The function entry point in your code"
  type        = string
  default     = "lambda_function.lambda_handler"
}

variable "lambda_runtime" {
  description = "The runtime environment for the Lambda function"
  type        = string
  default     = "python3.9"
}

variable "lambda_package" {
  description = "The path to the Lambda function deployment package"
  type        = string
}

variable "lambda_memory_size" {
  description = "Amount of memory allocated to the Lambda function"
  type        = number
  default     = 128
}

variable "lambda_timeout" {
  description = "The amount of time that Lambda allows a function to run before stopping it"
  type        = number
  default     = 5
}

variable "lambda_environment_variables" {
  description = "A map of environment variables to set for the Lambda function"
  type        = map(string)
  default     = {}
}
