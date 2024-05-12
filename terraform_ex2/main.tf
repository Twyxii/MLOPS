 variable "movie_name" {
  type = string
}

provider "local" {
}

resource "null_resource" exo2 {
    triggers = {
        test = var.movie_name
    }
  provisioner "local-exec" {
    command = "echo '${var.movie_name}' > film.txt"
  }
}

output "file_created_message" {
  value = "Fichier film.txt créé"
}

