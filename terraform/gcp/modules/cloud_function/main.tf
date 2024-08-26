resource "google_storage_bucket" "function_bucket" {
  name          = var.bucket_name
  location      = var.region
  force_destroy = true
}

resource "google_cloudfunctions_function" "cloud_function" {
  name        = var.function_name
  description = var.description
  runtime     = var.runtime
  region      = var.region

  source_archive_bucket = google_storage_bucket.function_bucket.name
  source_archive_object = var.source_archive_object
  entry_point           = var.entry_point

  trigger_http = true

  https_trigger_security_level = "SECURE_ALWAYS"

  environment_variables = var.environment_variables
}
