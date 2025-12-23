variable "region_aws" {
  description = "region de aws donde se deplega los recurso"
  default     = "us-east-1"

}

variable "instance_type" {
  description = "Instancia EC2"
  type        = string
  default     = "t2.micro"

}

variable "par_key" {
  description = "cloud2025"
  type        = string
}

