{ pkgs, lib, ... }:
{
  imports = [
    ./module/server.nix
    ./module/nixserver.nix
  ];
}
