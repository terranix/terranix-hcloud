
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
  hcloud-modules = pkgs.fetchgit{
    url = "https://github.com/mrVanDalo/terranix-hcloud.git";
    rev = "a020c6df7d5b301d561d1612737a4905a18dbdd4";
    sha256 = "0a3j9s5hljz1065gqrj304p6xj6grklrl8k7jblawx8c34kibd6y";
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
  
  hcloud.export.nix = toString ./generated.nix;
}
```

## with terraform version 0.12

To use this module with terranix and terraform version 0.12

```nix
{ config, lib, pkgs, ...}:
let
  hcloud-modules = pkgs.fetchgit{
    url = "https://github.com/mrVanDalo/terranix-hcloud.git";
    rev = "c3571f76664e1813f90d97b8c194a1e0149e895e";
    sha256 = "0plld74wincyy3c5gdfqh78pzrqibxh6r839dm0c717fajr9imwb";
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
  hcloud.export.nix = toString ./generated.nix;
}
```
