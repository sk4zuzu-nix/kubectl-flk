{
  description = "A flake for kubectl";

  inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-20.09;

  outputs = { self, nixpkgs }: {
    defaultPackage.x86_64-linux =
      with import nixpkgs { system = "x86_64-linux"; };

      stdenv.mkDerivation rec {
        name = "kubectl_sk4zuzu";
        version = "1.18.9";

        dontUnpack = true;

        src = fetchurl {
          url = "https://storage.googleapis.com/kubernetes-release/release/v${version}/bin/linux/amd64/kubectl";
          sha256 = "sha256-amh1ai09BLTQ9SsA3mSTuiwfyyizLz5KDpmz2fbE6O0=";
        };

        nativeBuildInputs = [ installShellFiles ];

        installPhase = ''
          install -D $src $out/kubectl
        '';

        fixupPhase = ":";
      };
  };
}
