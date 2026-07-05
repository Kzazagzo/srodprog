{ lib, pkgs, config, ... }:
let
  cfg = config.srodprog.goProtobuf;
in
{
  imports = [
    ../kernel.nix
    ../integrations/buf.nix
    ../integrations/grpc.nix
  ];

  options.srodprog.goProtobuf = {
    enable = lib.mkEnableOption "Go development with protobuf and gRPC tooling";
    bufCwd = lib.mkOption {
      type = lib.types.str;
      default = "./proto";
      description = "Directory containing buf configuration.";
    };
    generateTask = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Add proto:generate task running buf generate.";
    };
    grpcWeb = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Install grpc-web generator.";
    };
    lintTools = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Install common Go lint and refactor tools.";
    };
    debugTools = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Install Go debug and vulnerability tools.";
    };
  };

  config = lib.mkIf cfg.enable {
    languages.go.enable = true;

    srodprog = {
      buf = {
        enable = true;
        cwd = cfg.bufCwd;
        generateTask = cfg.generateTask;
      };
      grpc = {
        enable = true;
        go = true;
        web = cfg.grpcWeb;
      };
    };

    packages =
      with pkgs;
      [
        gopls
        gofumpt
        gotools
      ]
      ++ lib.optionals cfg.lintTools [
        golangci-lint
        gomodifytags
        impl
        iferr
        gotestsum
      ]
      ++ lib.optionals cfg.debugTools [
        delve
        govulncheck
      ];
  };
}
