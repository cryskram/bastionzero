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
              tflint
              jq
              graphviz
              google-cloud-sdk
              just
              ansible
              go
              gopls
              golangci-lint
              sops
              age
              openssh
              tailscale
              nixfmt
            ];
            shellHook = ''
              echo "BastionZero GCP development shell"
              export PATH="$HOME/.local/bin:$PATH"
              echo "gcloud: $(gcloud version 2>/dev/null | head -n1)"
              echo "Go: $(go version)"
              if command -v terraform >/dev/null 2>&1; then
                echo "Terraform: $(terraform version | head -n1)"
              else
                echo "Terraform: not installed yet; run scripts/install-terraform.sh"
              fi
            '';
          };
        }
      );

      formatter = forAllSystems (system: (import nixpkgs { inherit system; }).nixfmt);
    };
}
