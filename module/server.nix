{ config, lib, pkgs, ... }:
with lib;
with types;
let
  cfg = config.hcloud.server;
  allAdmins =
    if (hasAttr "admins" config.users)
    then config.users.admins
    else { };
in
{

  options.hcloud.server = mkOption {
    default = { };
    description = ''
      servers deployed to the hcloud.
    '';
    type =
      attrsOf (submodule ({ name, ... }: {
        options = {
          enable = mkEnableOption ''
            really deploy server
          '';
          name = mkOption {
            default = "${name}";
            type = str;
            description = ''
              name of the server
            '';
          };
          provisioners = mkOption {
            default = [ ];
            type = listOf attrs;
            description = ''
              provision steps.

              `file` and `remote-exec` steps
              automatically get the connection
              part setup, if you configure
              the `provisioner.privateKeyFile`
              parameter.
            '';
            example = [
              {
                file.source = "~/.zshrc";
                file.destination = "/root/.zshrc";
              }
              { remote-exec.inline = [ "shutdown -r +1" ]; }
            ];
          };
          image = mkOption {
            default = "ubuntu-18.04";
            type = str;
            description = ''
              image to spawn on the server
            '';
          };
          serverType = mkOption {
            default = "cx11";
            type = str;
            description = ''
              Hardware equipment. This options influences costs!
            '';
          };
          location = mkOption {
            default = null;
            type = nullOr str;
            description = ''
              location where the machine should run.
            '';
          };
          backups = mkOption {
            default = false;
            type = bool;
            description = ''
              enable backups or not
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

    hcloud.enable = true;

    resource.hcloud_server =
      let
        allUsers =
          mapAttrsToList (name: ignore: "\${ hcloud_ssh_key.server_${name}.id }")
            allAdmins;

        allResources = mapAttrs'
          (name: configuration: {
            name = "${configuration.name}";
            value = {
              # todo : check if name contains _ which is not allowed by hcloud
              name = configuration.name;
              image = configuration.image;
              server_type = configuration.serverType;
              backups = configuration.backups;
              location = configuration.location;
              ssh_keys = allUsers;
              provisioner = builtins.map
                (provisioner:
                  if (builtins.hasAttr "file" provisioner) then {
                    "file" = ({
                      connection = {
                        type = "ssh";
                        user = "root";
                        host = "\${ hcloud_server.${configuration.name}.ipv4_address }";
                        private_key =
                          ''''${ file("${config.provisioner.privateKeyFile}") }'';
                      };
                    } // provisioner.file);
                  } else if (builtins.hasAttr "remote-exec" provisioner) then {
                    "remote-exec" = ({
                      connection = {
                        type = "ssh";
                        user = "root";
                        host = "\${ hcloud_server.${configuration.name}.ipv4_address }";
                        private_key =
                          ''''${ file("${config.provisioner.privateKeyFile}") }'';
                      };
                    } // provisioner.remote-exec);
                  } else
                    provisioner)
                configuration.provisioners;
            } // configuration.extraConfig;
          })
          cfg;
      in
      allResources;

    output =
      let
        ipv4Address = mapAttrs'
          (ignore: configuration: {
            name = "${configuration.name}_ipv4_address";
            value = {
              value = "\${ hcloud_server.${configuration.name}.ipv4_address }";
            };
          })
          cfg;

        ipv6Address = mapAttrs'
          (ignore: configuration: {
            name = "${configuration.name}_ipv6_address";
            value = {
              value = "\${ hcloud_server.${configuration.name}.ipv6_address }";
            };
          })
          cfg;

      in
      ipv4Address // ipv6Address;

    resource.hcloud_ssh_key =
      let
        allResources = mapAttrs'
          (name: configuration: {
            name = "server_${name}";
            value = {
              name = "SSH Key ${name}";
              public_key = configuration.publicKey;
            };
          })
          allAdmins;
      in
      allResources;

  };
}
