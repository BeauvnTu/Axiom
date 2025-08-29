# Axiom

Declarative NixOS dotfiles that treat every boot as a self-evident, reproducible axiom.


## Q&A

**Q: How to manage dotfiles?**
**A**: Use home-manager. You can execute the command `nix run home-manager/master -- switch --flake .#syourl`, this command will temporary execution home-manager and switch the config which is defined in the flake.nix.


## Reference
* [Home Manager](https://github.com/nix-community/home-manager)
* [NixOS Wiki - Home Manager](https://nixos.wiki/wiki/Home_Manager)
* [mitchellh - nixos-config](https://github.com/mitchellh/nixos-config/blob/main/users/mitchellh/home-manager.nix)
