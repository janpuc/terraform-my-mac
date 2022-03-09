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

  provisioner "remote-exec" {
    inline = [
      "export PATH=/usr/local/bin:$PATH",
      "echo $PATH",
      "echo ${var.password} | sudo -S echo Workaround",
      "export CI=1",
      "curl -O https://raw.githubusercontent.com/${var.github-user}/dotfiles/HEAD/Brewfile",
      "/bin/bash -c \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\"",
      "brew update",
      "brew bundle",
      "brew cleanup",
      "echo Brew setup finished!",

      "chezmoi init --apply https://github.com/janpuc/dotfiles.git",
      "echo Chezmoi setup finished!",
    ]
  }
}
