{ lib, pkgs, config, ... }:
let
  cfg = config.srodprog.nixTools;
in
{
  imports = [ ../kernel.nix ];

  options.srodprog.nixTools.enable = lib.mkEnableOption "Nix language and maintenance tools";

  config = lib.mkIf cfg.enable {
    packages = with pkgs; [
      deadnix
      nixd
      nixfmt-rfc-style
      statix
    ];
  };
}
