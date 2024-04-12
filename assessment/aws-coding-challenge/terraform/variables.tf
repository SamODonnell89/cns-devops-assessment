variable "region" {
  description = "AWS region"
  default     = "ap-southeast-2"
}

variable ami {
  type      = string
  default   = "ami-09c8d5d747253fb7a" # ubuntu 22.04 ami
}

variable env {
  type      = string
  default   = "dev"
}

variable app {
  type      = string
  default   = "current-time"
}

variable account_id {
  type      = string
  default   = "421039062885"
}
