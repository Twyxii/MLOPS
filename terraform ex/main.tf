provider "local" {
}

resource "null_resource" "create_file" {
  
  provisioner "local-exec" {
    command = "echo '${var.movie_name}' > film.txt"  
  }
}

variable "movie_name" {
  description = "Nom de votre film préféré"
  type        = string
  default     = "NomDuFilm"  
}
