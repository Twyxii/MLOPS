variable "movies_info" {
  type        = list(object({
    name = string
    comment = string
  }))
  default = [
    {
      name = "Hunger games 2"
      comment = "Un film d'action palpitant."
    },
    {
      name = "Avenger Infinite War"
      comment = "Un film de super-héros épique."
    },
    {
      name = "Case départ"
      comment = "Une comédie française hilarante."
    }
  ]
}

provider "local" {}

resource "null_resource" exo_4 {
  for_each = { for idx, movie in var.movies_info : idx => movie }

  provisioner "local-exec" {
    command = "echo ${each.value.name}: ${each.value.comment} >> Movies.txt"
  }
}
