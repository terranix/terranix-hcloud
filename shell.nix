{ pkgs ? import <nixpkgs> { } }:
let
  terranix = pkgs.callPackage (pkgs.fetchgit {
    url = "https://github.com/mrVanDalo/terranix.git";
    rev = "68f1addf0f7ea0e87e18dc1cf88e334f03b3f90b";
    sha256 = "14lr0pnk2a0ihdq51xljj2xcqb75chn3cp2pmhp8dc8bpvrbr0g6";
  }) { };
in pkgs.mkShell {

  buildInputs = [
    terranix
    # terraform wrapper
    (pkgs.writeShellScriptBin "terraform" ''
      export TF_VAR_hcloud_api_token=`${pkgs.pass}/bin/pass development/hetzner.com/api-token`
      ${pkgs.terraform_0_11}/bin/terraform "$@"
    '')
  ];

}
