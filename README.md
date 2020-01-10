
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
    url = "https://git.ingolf-wagner.de/terranix/hcloud.git";
    rev = "36666629252ebe71cc658da49f5dcc3fa4718396";
    sha256 = "1r29q19dbzbc79i0zdjrrcxilxiyp74057rrc8qs6v74sv11hail";
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
    url = "https://git.ingolf-wagner.de/terranix/hcloud.git";
    rev = "af678d11a381394301967dd44bcd6aacd636cd47";
    sha256 = "0qmd8blr1i12y8gpj1vhch5c722plkyhdkn7n4f268n46dha0bxm";
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
