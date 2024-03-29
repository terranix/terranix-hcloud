{ config, lib, pkgs, ... }:
with lib;
let cfg = config.hcloud.export;
in {

  options.hcloud.export = {
    nix = mkOption {
      type = with types; nullOr str;
      default = null;
      description = ''
        Export hcloud information as nix file.
        Useful when if you want to import
        run a NixOS script after the terraform.
      '';
    };
  };

  config = mkIf (cfg.nix != null) {
    resource.local_file = {
      hcloud_export_nix = {
        content =
          let
            serverPart = name: ''
              ${name} = {
                host = {
                  ipv4 = "''${ hcloud_server.${name}.ipv4_address }";
                  ipv6 = "''${ hcloud_server.${name}.ipv6_address }";
                };
                location = "''${ hcloud_server.${name}.location }";
                backups = ''${ hcloud_server.${name}.backups};
              };
            '';
            allServerParts = map serverPart (attrNames config.hcloud.server);
          in
          ''
            # generated by terranix-hcloud : hcloud.export.nix
            # it lists every return value created
            # by the hcloud provider in nix format
            # so you can import it in another nix-lang tool
            {

            # hcloud servers:
            ${concatStringsSep "\n" allServerParts}
            }
          '';
        filename = cfg.nix;
      };
    };
  };

}
