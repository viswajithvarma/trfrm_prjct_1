output "cluster_name" {
  description = "Name of the Dataproc cluster"
  value       = google_dataproc_cluster.cluster.name
}

output "cluster_self_link" {
  description = "Self link of the Dataproc cluster"
  value       = google_dataproc_cluster.cluster
}

output "master_instance_names" {
  description = "Names of the master instances"
  value       = google_dataproc_cluster.cluster.cluster_config[0].master_config[0].instance_names
}

output "worker_instance_names" {
  description = "Names of the worker instances"
  value       = google_dataproc_cluster.cluster.cluster_config[0].worker_config[0].instance_names
}

output "bucket" {
  description = "GCS bucket used by the cluster"
  value       = google_dataproc_cluster.cluster.cluster_config[0].bucket
}
