{ lib, pkgs, config, ... }:
let
  cfg = config.srodprog.androidRust;
in
{
  imports = [
    ../kernel.nix
    ./android.nix
    ./rust.nix
  ];

  options.srodprog.androidRust = {
    enable = lib.mkEnableOption "Android and Rust cross-compilation preset";
    rustTargets = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [
        "aarch64-linux-android"
        "x86_64-linux-android"
      ];
      description = "Rust targets for Android builds.";
    };
  };

  config = lib.mkIf cfg.enable {
    srodprog.android.enable = true;

    srodprog.rust = {
      enable = true;
      targets = cfg.rustTargets;
    };

    packages = lib.mkAfter [ pkgs.cargo-ndk ];
  };
}
