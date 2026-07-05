{ lib, config, ... }:
let
  cfg = config.srodprog;
in
{
  options.srodprog = {
    enterMessage = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      example = "project dev shell";
      description = "Optional message printed when entering the shell.";
    };
  };

  config = lib.mkIf (cfg.enterMessage != null) {
    enterShell = ''
      echo "${cfg.enterMessage}"
    '';
  };
}
