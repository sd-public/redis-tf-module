provider "aws" {
  alias  = "primary"
  region = var.primary_region
}

provider "aws" {
  alias  = "secondary-1"
  region = var.secondary_region-1
}

provider "aws" {
  alias  = "secondary-2"
  region = var.secondary_region-2
}
