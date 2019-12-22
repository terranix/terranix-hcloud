
An opinionated hcloud
[terranix](https://terranix.org/)
module you can use.


Sadly terraform changes a lot in it's versions
so you have to use different modules for different
terraform versions.
The modules try to provide the same terranix interface tough
so you have minimal migration trouble.

## with terraform version 0.11

To use this module with terranix and terraform version 0.11

```nix
{ config, lib, pkgs, ...}:
let
  hcloud-modules = pkgs.fetchgit {
    url = "https://github.com/mrVanDalo/terranix-hcloud.git";
    rev = "b6896f385f45ecfd66e970663c55635c9fd8b26b";
    sha256 = "1bggnbry7is7b7cjl63q6r5wg9pqz0jn8i3nnc4rqixp0ckwdn85";
  };
in
{
  imports = [
    (toString hcloud-modules)
  ];

  # configure admin ssh keys
  users.admins.palo.publicKey = "${lib.fileContents ./sshkey.pub}";

  # configure provisioning private Key to be used when running provisioning on the machines
  provisioner.privateKeyFile = toString ./sshkey;

  hcloud.nixserver.server1 = {
    enable = true;
    configurationFile = pkgs.writeText "configuration.nix" ''
      { pkgs, lib, config, ... }:
      { environment.systemPackages = [ pkgs.git ]; }
    '';
  };
}
```

## with terraform version 0.12

To use this module with terranix and terraform version 0.12

```nix
{ config, lib, pkgs, ...}:
let
  hcloud-modules = pkgs.fetchgit {
    url = "https://github.com/mrVanDalo/terranix-hcloud.git";
    rev = "97fffd7b3758f0ff69edce2b346bb3f48cffe4d4";
    sha256 = "1z4diy5fr1pgmpzhwa078kb00gk2m35b0yb9hm40n8a8wc7l4csr";
  };
in
{
  imports = [
    (toString hcloud-modules)
  ];

  # configure admin ssh keys
  users.admins.palo.publicKey = "${lib.fileContents ./sshkey.pub}";

  # configure provisioning private Key to be used when running provisioning on the machines
  provisioner.privateKeyFile = toString ./sshkey;

  hcloud.nixserver.server1 = {
    enable = true;
    configurationFile = pkgs.writeText "configuration.nix" ''
      { pkgs, lib, config, ... }:
      { environment.systemPackages = [ pkgs.git ]; }
    '';
  };
}
```
