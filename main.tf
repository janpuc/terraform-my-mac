resource "null_resource" "mac" {

  triggers = {
    always_run = "${timestamp()}"
  }

  connection {
    type     = "ssh"
    user     = var.user
    password = var.password
    host     = var.host
  }

  provisioner "file" {
    source      = "setup.sh"
    destination = "/tmp/setup.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/setup.sh",
      "/tmp/setup.sh ${var.github-user} ${var.password}",
    ]
  }
}
