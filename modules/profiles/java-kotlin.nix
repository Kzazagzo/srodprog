{ lib, pkgs, config, ... }:
let
  cfg = config.srodprog.javaKotlin;
in
{
  imports = [ ../kernel.nix ];

  options.srodprog.javaKotlin = {
    enable = lib.mkEnableOption "Java and Kotlin development preset";
    jdkPackage = lib.mkOption {
      type = lib.types.package;
      default = pkgs.jdk21;
      defaultText = "pkgs.jdk21";
      description = "JDK package used by devenv.";
    };
    kotlin = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable Kotlin support.";
    };
  };

  config = lib.mkIf cfg.enable {
    languages.java = {
      enable = true;
      jdk.package = cfg.jdkPackage;
    };

    languages.kotlin.enable = cfg.kotlin;

    env.JAVA_HOME = "${cfg.jdkPackage}/lib/openjdk";
  };
}
