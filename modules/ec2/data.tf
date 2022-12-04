resource "random_shuffle" "subnet" {
  input        = var.subnet_ids
  result_count = 1
}