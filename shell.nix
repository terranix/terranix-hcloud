{ pkgs ?  import <nixpkgs> {} }:

let

  terranix = pkgs.callPackage (pkgs.fetchgit {
    url = "https://github.com/mrVanDalo/terranix.git";
    rev = "6097722f3a94972a92d810f3a707351cd425a4be";
    sha256 = "1d8w82mvgflmscvq133pz9ynr79cgd5qjggng85byk8axj6fg6jw";
  }) { };

in pkgs.mkShell {

  buildInputs = with pkgs; [
    terranix

    # terraform wrapper
    (pkgs.writeShellScriptBin "terraform" ''
      export TF_VAR_hcloud_api_token=`${pkgs.pass}/bin/pass development/hetzner.com/api-token`
      ${pkgs.terraform_0_11}/bin/terraform "$@"
    '')
  ];

}
