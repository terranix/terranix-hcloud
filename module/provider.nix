{ config, lib, ... }:

with lib;

let
  cfg = config.hcloud;
  default_token = "hcloud_api_token";
in
{

  options.hcloud = {
    enable = mkEnableOption ''
      hcloud provider
      See https://www.terraform.io/docs/providers/hcloud/index.html for documentation.
    '';
    provider = {
      token = mkOption {
        type = with types; str;
        default = "\${ var.${default_token} }";
        description = ''
          You need an API token to use the API.
          Sign in into the Hetzner Cloud Console choose a project,
          go to Access → Tokens, and create a new token. Make sure
          to copy the token because it won’t be shown to you again.
          A token is bound to a project, to interact with the API of another
          project you have to create a new token inside the project

          If you use a variable you can set it via the environment variable
          TF_VAR_${default_token}.
        '';
      };
      endpoint = mkOption {
        default = null;
        type = with types; nullOr str;
        description = ''
          Hetzner Cloud API endpoint,
          can be used to override the default API Endpoint https://api.hetzner.cloud/v1
        '';
      };
    };
  };

  config = mkMerge [

    (mkIf cfg.enable {
      provider.hcloud = cfg.provider;
      terraform.required_providers.hcloud.source = "hetznercloud/hcloud";
    })

    (mkIf (cfg.enable && cfg.provider.token == "\${ var.${default_token} }") {
      variable."${default_token}" = {
        description = ''
          This is the Hetzner Cloud API Token,
          can also be specified with the TF_VAR_${default_token} environment variable.
        '';
      };
    })

  ];
}
