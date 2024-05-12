variable "movies_info" {
  type = list(object({
    name     = string
    comment  = string
  }))
  default = [
    {
      name    = "Hunger Games 2"
      comment = "Un film d'action palpitant."
    },
    {
      name    = "Avengers: Infinity War"
      comment = "Un film de super-héros épique."
    },
    {
      name    = "Case départ"
      comment = "Une comédie française hilarante."
    },
  ]
}

provider "local" {}

resource "null_resource" "write_movies" {
  for_each = { for idx, movie in var.movies_info : idx => movie }

  provisioner "local-exec" {
    command = "echo ${each.value.name}: ${each.value.comment} >> Movies.txt"
  }
}

output "file_created_message" {
  value = "Fichier Movies.txt créé"
}
