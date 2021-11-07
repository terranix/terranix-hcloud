{ pkgs ? import <nixpkgs> { } }:
let

  terraform = pkgs.writers.writeBashBin "terraform" ''
    export TF_VAR_hcloud_api_token=`${pkgs.pass}/bin/pass development/hetzner.com/api-token`
    ${pkgs.terraform_0_15}/bin/terraform "$@"
  '';

in
pkgs.mkShell {

  buildInputs = [

    pkgs.terranix
    terraform

    (pkgs.writers.writeBashBin "test-prepare" ''
      ${pkgs.openssh}/bin/ssh-keygen -P "" -f ${toString ./.}/sshkey
    '')

    (pkgs.writers.writeBashBin "test-cleanup" ''
      ${terraform}/bin/terraform destroy
      rm ${toString ./.}/config.tf.json
      rm ${toString ./.}/sshkey
      rm ${toString ./.}/sshkey.pub
      rm ${toString ./.}/terraform.tfstate*
    '')

    (pkgs.writers.writeBashBin "test-run" ''
      set -e
      ${pkgs.terranix}/bin/terranix | ${pkgs.jq}/bin/jq '.' > config.tf.json
      ${terraform}/bin/terraform init
      ${terraform}/bin/terraform apply
    '')

  ];
}

