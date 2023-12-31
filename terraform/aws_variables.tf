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
 * Terraform variable declarations for AWS.
 */

variable "aws_credentials_file_path" {
  description = "Locate the AWS credentials file."
  type        = string
}

variable "aws_region" {
  description = "Default to Oregon region."
  default     = "us-west-2"
}

variable "aws_instance_type" {
  description = "Machine Type. Includes 'Enhanced Networking' via ENA."
  default     = "t3.micro"
}

variable "aws_disk_image" {
  description = "Boot disk for gcp_instance_type."
  default     = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
}

variable "aws_network_cidr" {
  description = "VPC network ip block."
  default     = "172.16.0.0/16"
}

variable "aws_subnet1_cidr" {
  description = "Subset block from VPC network ip block."
  default     = "172.16.0.0/24"
}

variable "aws_vm_address" {
  description = "Private IP address for AWS VM instance."
  default     = "172.16.0.100"
}

