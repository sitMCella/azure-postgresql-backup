resource "null_resource" "docker_image" {
  triggers = {
    image_name         = "${var.container_registry_login_server}/postgresql/postgresql-client"
    image_tag          = "latest"
    registry_name      = var.container_registry_name
    dockerfile_path    = "${path.cwd}/application/postgresql_client/Dockerfile"
    dockerfile_context = "${path.cwd}/application/postgresql_client"
    dir_sha1           = sha1(join("", [for f in fileset(path.cwd, "application/postgresql_client/*") : filesha1(f)]))
  }
  provisioner "local-exec" {
    command     = "./scripts/docker_build_and_push_to_acr.sh ${var.subscription_id} ${self.triggers.image_name} ${self.triggers.image_tag} ${self.triggers.registry_name} ${self.triggers.dockerfile_path} ${self.triggers.dockerfile_context}"
    interpreter = ["bash", "-c"]
  }
}
