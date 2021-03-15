{
  description = "A flake for kubectl, kubectx and kubens";

  inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-20.09;

  outputs = { self, nixpkgs }: {
    defaultPackage.x86_64-linux =
      with import nixpkgs { system = "x86_64-linux"; };

      stdenv.mkDerivation rec {
        name = "kubectl_sk4zuzu";

        dontUnpack = true;

        kubectl_ver = "1.18.9";
        kubectl_src = fetchurl {
          url = "https://storage.googleapis.com/kubernetes-release/release/v${kubectl_ver}/bin/linux/amd64/kubectl";
          sha256 = "sha256-amh1ai09BLTQ9SsA3mSTuiwfyyizLz5KDpmz2fbE6O0=";
        };

        kubectx_ver = "0.9.3";
        kubectx_src = fetchurl {
          url = "https://github.com/ahmetb/kubectx/releases/download/v${kubectx_ver}/kubectx";
          sha256 = "sha256-6Ifk4rPdTJTQ7NuEJw+0+sLmXE1bDuRh5oj7gIn9SQA=";
        };

        kubens_ver = "0.9.3";
        kubens_src = fetchurl {
          url = "https://github.com/ahmetb/kubectx/releases/download/v${kubens_ver}/kubens";
          sha256 = "sha256-UJyXwIguaIro+tiqE1JMx8AD5Ig9tEepBb20fWTBO9w=";
        };

        kubeps1_ver = "0.7.0";
        kubeps1_src = fetchurl {
          url = "https://raw.githubusercontent.com/jonmosco/kube-ps1/v${kubeps1_ver}/kube-ps1.sh";
          sha256 = "sha256-nhp4IHJSYejIhWakDhWSx7l/QTz8dO2yz8rmurfv1Bc=";
        };

        nativeBuildInputs = [ installShellFiles ];

        installPhase = ''
          install -D $kubectl_src $out/kubectl
          install -D $kubectx_src $out/kubectx
          install -D $kubens_src $out/kubens
          install -D $kubeps1_src $out/kube-ps1.sh
        '';

        fixupPhase = ":";
      };
  };
}
