/*
 * Copyright 2017 Google Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/*
 * Terraform compute resources for GCP.
 * Acquire all zones and choose one randomly.
 */

data "google_compute_zones" "available" {
  region = var.gcp_region
}

resource "google_compute_address" "gcp-ip" {
  name   = "gcp-vm-ip"
  region = var.gcp_region
}

resource "google_compute_instance" "tcb-gcp-vm-01" {
  name         = "tcb-gcp-vm-01"
  machine_type = var.gcp_instance_type
  zone         = data.google_compute_zones.available.names[0]

  boot_disk {
    initialize_params {
      image = var.gcp_disk_image
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.tcb-gcp-subnet1.name
    network_ip = var.gcp_vm_address

    access_config {
      # Static IP
      nat_ip = google_compute_address.gcp-ip.address
    }
  }

  metadata = {
    ssh-key = "oziel:${file("~/.ssh/id_rsa.pub")}"
  }

  # Cannot pre-load both gcp and aws since that creates a circular dependency.
  # Can pre-populate the AWS IPs to make it easier to run tests.
  metadata_startup_script = replace(
    replace(file("vm_userdata.sh"), "<EXT_IP>", aws_eip.aws-ip.public_ip),
    "<INT_IP>",
    var.aws_vm_address,
  )
}

