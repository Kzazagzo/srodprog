{ lib, pkgs, config, ... }:
let
  cfg = config.srodprog.android;
in
{
  imports = [
    ../kernel.nix
    ./java-kotlin.nix
  ];

  options.srodprog.android = {
    enable = lib.mkEnableOption "Android development preset";
    platforms = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ "36" ];
      description = "Android platform versions.";
    };
    abis = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [
        "arm64-v8a"
        "x86_64"
      ];
      description = "Android ABIs.";
    };
    ndk = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable Android NDK.";
      };
      versions = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ "26.1.10909125" ];
        description = "Android NDK versions.";
      };
    };
    buildTools = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ "36.0.0" ];
      description = "Android build tools versions.";
    };
    jdkPackage = lib.mkOption {
      type = lib.types.package;
      default = pkgs.jdk21;
      defaultText = "pkgs.jdk21";
      description = "JDK package used for Android builds.";
    };
    kotlin = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable Kotlin support.";
    };
  };

  config = lib.mkIf cfg.enable {
    android = {
      enable = true;
      platforms.version = cfg.platforms;
      inherit (cfg) abis;
      ndk = {
        inherit (cfg.ndk) enable;
        version = cfg.ndk.versions;
      };
      buildTools.version = cfg.buildTools;
    };

    srodprog.javaKotlin = {
      enable = true;
      jdkPackage = cfg.jdkPackage;
      kotlin = cfg.kotlin;
    };
  };
}
