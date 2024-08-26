output "cloud_function_name" {
  description = "The name of the Google Cloud Function"
  value       = google_cloudfunctions_function.cloud_function.name
}

output "cloud_function_url" {
  description = "The URL of the Google Cloud Function"
  value       = google_cloudfunctions_function.cloud_function.https_trigger_url
}
