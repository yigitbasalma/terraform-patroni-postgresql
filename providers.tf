terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
    curl = {
      source = "anschoewe/curl"
      version = "0.1.4"
    }
  }
  backend "s3" {
    bucket = "infra-as-a-code-u48a71"
  }
}

# Configure default provider
provider "aws" {
  region  = var.region
  profile = var.profile
}

provider "curl" {}