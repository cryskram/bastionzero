{
  description = "bastionzero IaC";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      devShells = forAllSystems (
        system:
        let
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
        in
        {
          default = pkgs.mkShellNoCC {
            packages = with pkgs; [
              terraform
              python313
              uv
              tflint
              jq
              graphviz
              just
              sops
              age
              openssh
              tailscale
              nixfmt
            ];
            shellHook = ''
              echo "bastionzero IaC dev shell"
              echo "terraform version: $(terraform version | head -n 1)"
            '';
          };
        }
      );

      formatter = forAllSystems (system: (import nixpkgs { inherit system; }).nixfmt);
    };
}
