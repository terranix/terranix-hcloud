{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.hcloud.nixserver;

  nixosInfect = pkgs.fetchgit {
    "url" = "https://github.com/elitak/nixos-infect.git";
    "rev" = "30441b1236a3f5e426b72ecf2ba2f4f91127ca0e";
    "sha256" = "0k6z4wx8k03psbhm2mzm575z6gas2c6fl2pxpppwamjdvl0gv2an";
  };

in
{

  options.hcloud.nixserver = mkOption {
    default = { };
    description = ''
      create a nixos server, via nixos-infect.
    '';
    type = with types;
      attrsOf (submodule ({ name, ... }: {
        options = {
          enable = mkEnableOption "nixserver";

          # todo eine option für zusätzlichen speicher
          name = mkOption {
            default = "nixserver-${name}";
            type = with types; str;
            description = ''
              name of the server
            '';
          };
          serverType = mkOption {
            default = "cx11";
            type = with types; str;
            description = ''
              Hardware equipment.This options influences costs!
            '';
          };
          channel = mkOption {
            default = "nixos-21.05";
            type = with types; str;
            description = ''
              nixos channel to install
            '';
          };
          backups = mkOption {
            default = false;
            type = with types; bool;
            description = ''
              enable backups or not
            '';
          };
          configurationFile = mkOption {
            default = null;
            type = with types; nullOr path;
            description = ''
              The configuration.nix,
              only used by the initial
              provisioning by nixos-infect.
            '';
          };
          location = mkOption {
            default = null;
            type = nullOr str;
            description = ''
              location where the machine should run.
            '';
          };
          provisioners = mkOption {
            default = [ ];
            type = with types; listOf attrs;
            description = ''
              provision steps. see `hcloud.server.provisioners`.
            '';
          };
          extraConfig = mkOption {
            default = { };
            type = attrs;
            description = ''
              parameter of the hcloud_server which are not covered yet.
            '';
          };
        };
      }));
  };

  config = mkIf (cfg != { }) {

    hcloud.server = mapAttrs'
      (name: configuration: {
        name = "${configuration.name}";
        value = {
          inherit (configuration) enable serverType backups name location extraConfig;
          provisioners = [
            {
              file.source = "${nixosInfect}/nixos-infect";
              file.destination = "/root/nixos-infect";
            }
            (optionalAttrs (configuration.configurationFile != null) {
              file.source = toString configuration.configurationFile;
              file.destination = "/etc/nixos_input.nix";
            })
          ] ++ configuration.provisioners ++ [{
            remote-exec.inline = [
              ''
                NO_REBOOT="dont" \
                PROVIDER=HCloud \
                NIX_CHANNEL=${configuration.channel} \
                ${
                  optionalString (configuration.configurationFile != null)
                  "NIXOS_IMPORT=/etc/nixos_input.nix"
                } \
                bash /root/nixos-infect 2>&1 | tee /tmp/infect.log
              ''
              "shutdown -r +1"
            ];
          }];
        };
      })
      cfg;
  };

}
