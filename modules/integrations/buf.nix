{ lib, pkgs, config, ... }:
let
  cfg = config.srodprog.buf;
in
{
  imports = [ ../kernel.nix ];

  options.srodprog.buf = {
    enable = lib.mkEnableOption "Buf protobuf tooling";
    generateTask = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Add proto:generate task running buf generate.";
    };
    cwd = lib.mkOption {
      type = lib.types.str;
      default = "./proto";
      description = "Working directory for buf tasks.";
    };
  };

  config = lib.mkIf cfg.enable {
    packages = [ pkgs.buf ];

    tasks = lib.mkIf cfg.generateTask {
      "proto:generate" = {
        exec = "buf generate";
        cwd = cfg.cwd;
      };
    };
  };
}
