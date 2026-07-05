{ lib, pkgs, config, ... }:
let
  cfg = config.srodprog.pythonUv;
in
{
  imports = [
    ../kernel.nix
    ../integrations/ide-python-venv.nix
  ];

  options.srodprog.pythonUv = {
    enable = lib.mkEnableOption "Python development with uv";
    version = lib.mkOption {
      type = lib.types.str;
      default = "3.12";
      description = "Python version used by devenv.";
    };
    ideVenvSymlink = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Create .venv symlink to DEVENV_STATE/venv for IDEs.";
    };
  };

  config = lib.mkIf cfg.enable {
    env.UV_PYTHON_DOWNLOADS = "never";

    languages.python = {
      enable = true;
      inherit (cfg) version;
      uv = {
        enable = true;
        sync.enable = true;
      };
      venv.enable = true;
    };

    packages = [ pkgs.uv ];

    srodprog.idePythonVenv.enable = cfg.ideVenvSymlink;
  };
}
