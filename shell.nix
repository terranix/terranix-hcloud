{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {

  buildInputs = with pkgs; [
    pkgs.terranix

    # terraform wrapper
    (pkgs.writeShellScriptBin "terraform" ''
      export TF_VAR_hcloud_api_token=`${pkgs.pass}/bin/pass development/hetzner.com/api-token`
      ${pkgs.terraform_0_12}/bin/terraform "$@"
    '')
  ];

}
