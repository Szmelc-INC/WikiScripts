# WikiScripts
Scripts, scrappers, and other CLI tools for scripting Wikipedia.org

## Install

[![nix](https://github.com/Szmelc-INC/WikiScripts/actions/workflows/nix.yml/badge.svg)](https://github.com/Szmelc-INC/WikiScripts/actions/workflows/nix.yml)

**Arch Linux** via [SAUR](https://github.com/Szmelc-INC/SAUR):

```sh
curl -fsSL https://szmelc-inc.github.io/SAUR/add | sudo bash   # once: adds [saur] to pacman.conf
sudo pacman -S wikiscripts-git
```

**Nix**:

```sh
nix run github:Szmelc-INC/WikiScripts
nix profile install github:Szmelc-INC/WikiScripts
nix develop          # dev shell inside a clone
```

Then run `wiki-random-article --help`.
