{ lib, pkgs, config, ... }:
let
  cfg = config.srodprog.rust;
in
{
  imports = [ ../kernel.nix ];

  options.srodprog.rust = {
    enable = lib.mkEnableOption "Rust development preset";
    channel = lib.mkOption {
      type = lib.types.str;
      default = "stable";
      description = "Rust channel used by devenv.";
    };
    components = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [
        "rustc"
        "cargo"
        "clippy"
        "rustfmt"
        "rust-analyzer"
        "rust-src"
      ];
      description = "Rustup components installed by devenv.";
    };
    targets = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "Additional Rust compilation targets.";
    };
    perfTools = lib.mkEnableOption "Linux profiling tools";
    just = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Install just.";
    };
  };

  config = lib.mkIf cfg.enable {
    languages.rust = {
      enable = true;
      inherit (cfg) channel components targets;
    };

    packages =
      lib.optionals cfg.just [ pkgs.just ]
      ++ lib.optionals cfg.perfTools [ pkgs.linuxPackages.perf ];
  };
}
