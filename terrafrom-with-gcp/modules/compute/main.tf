# Dataproc cluster module

resource "google_dataproc_cluster" "cluster" {
  name   = var.cluster_name
  region = var.region

  cluster_config {
    master_config {
      num_instances = var.master_num_instances
      machine_type  = var.master_machine_type
      disk_config {
        boot_disk_type    = var.boot_disk_type
        boot_disk_size_gb = var.boot_disk_size_gb
      }
    }

    worker_config {
      num_instances = var.worker_num_instances
      machine_type  = var.worker_machine_type
      disk_config {
        boot_disk_type    = var.boot_disk_type
        boot_disk_size_gb = var.boot_disk_size_gb
      }
    }

    preemptible_worker_config {
      num_instances = var.preemptible_num_instances
    }

    software_config {
      image_version = var.image_version
      override_properties = var.override_properties
    }

    gce_cluster_config {
      tags = var.tags
      
      dynamic "shielded_instance_config" {
        for_each = var.enable_shielded_vm ? [1] : []
        content {
          enable_secure_boot          = true
          enable_vtpm                 = true
          enable_integrity_monitoring = true
        }
      }
    }
  }
}
