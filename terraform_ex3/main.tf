 variable "movies_names" {
  type        = map
  default     = {
    film1 = "Hunger games 2"
    film2 = "Avenger Infinite War"
    film3 = "Case départ"
  }
}

provider "local" {
}

resource "null_resource" exo3 {
    for_each = var.movies_names
    triggers = {
        foo= each.value
    }
  provisioner "local-exec" {
    command = "echo ${each.key}: ${each.value} >> film.txt"
  }
}

output "file_created_message" {
  value = "Fichier film.txt créé"
}

