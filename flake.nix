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
          sha256 = "sha256-XppSXdfjE34sss+rRysWjGRz6CooYX4NmvsCFxH6+Ig=";
          executable = true;
        };

        kubectx_ver = "0.9.3";
        kubectx_src = fetchurl {
          url = "https://github.com/ahmetb/kubectx/releases/download/v${kubectx_ver}/kubectx";
          sha256 = "sha256-pYaOmRLFvBOWchVHFRbZtwHx6+46LzlkwCLy/xqc5MA=";
          executable = true;
        };

        kubens_ver = "0.9.3";
        kubens_src = fetchurl {
          url = "https://github.com/ahmetb/kubectx/releases/download/v${kubens_ver}/kubens";
          sha256 = "sha256-85c6xcW8ve15PozN6D33ZOUGV9vAAW5X2VAJ3gUy+Ww=";
          executable = true;
        };

        kubeps1_ver = "0.7.0";
        kubeps1_src = fetchurl {
          url = "https://raw.githubusercontent.com/jonmosco/kube-ps1/v${kubeps1_ver}/kube-ps1.sh";
          sha256 = "sha256-yGGiyeDtqTcGo2kFOk1S+UMVTzABeoePZ+uDB1TbxxQ=";
          executable = true;
        };

        nativeBuildInputs = [ installShellFiles ];

        dontPatch     = true;
        dontConfigure = true;
        dontBuild     = true;
        dontFixup     = true;

        installPhase = ''
          install -D $kubectl_src $out/kubectl
          install -D $kubectx_src $out/kubectx
          install -D $kubens_src $out/kubens
          install -D $kubeps1_src $out/kube-ps1.sh
        '';
      };
  };
}
