{ pkgs, lib, ... }:
{
  imports = [
    ./module/provider.nix
    ./module/server.nix
    ./module/nixserver.nix
    ./module/export.nix
  ];
}
