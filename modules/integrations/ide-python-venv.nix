{ lib, config, ... }:
let
  cfg = config.srodprog.idePythonVenv;
in
{
  imports = [ ../kernel.nix ];

  options.srodprog.idePythonVenv.enable =
    lib.mkEnableOption "Create .venv symlink for Python IDE integration";

  config = lib.mkIf cfg.enable {
    enterShell = ''
      if [ -n "''${DEVENV_ROOT:-}" ] && [ -n "''${DEVENV_STATE:-}" ] && [ ! -e "$DEVENV_ROOT/.venv" ]; then
        ln -s "$DEVENV_STATE/venv/" "$DEVENV_ROOT/.venv"
      fi
    '';
  };
}
