{
  description = "Personal devenv preset library";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    devenv.url = "github:cachix/devenv";
  };

  outputs =
    { self, ... }:
    {
      devenvModules = {
        default = ./modules/kernel.nix;
        kernel = ./modules/kernel.nix;

        android = ./modules/profiles/android.nix;
        android-rust = ./modules/profiles/android-rust.nix;
        go-protobuf = ./modules/profiles/go-protobuf.nix;
        java-kotlin = ./modules/profiles/java-kotlin.nix;
        nix-tools = ./modules/profiles/nix-tools.nix;
        python-uv = ./modules/profiles/python-uv.nix;
        rust = ./modules/profiles/rust.nix;

        buf = ./modules/integrations/buf.nix;
        grpc = ./modules/integrations/grpc.nix;
        ide-python-venv = ./modules/integrations/ide-python-venv.nix;
      };

      templates = {
        rust = {
          path = ./templates/rust;
          description = "devenv Rust project using srodprog";
        };
        python-uv = {
          path = ./templates/python-uv;
          description = "devenv Python uv project using srodprog";
        };
        android-rust = {
          path = ./templates/android-rust;
          description = "devenv Android + Rust project using srodprog";
        };
      };
    };
}
