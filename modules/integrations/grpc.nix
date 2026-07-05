{ lib, pkgs, config, ... }:
let
  cfg = config.srodprog.grpc;
in
{
  imports = [ ../kernel.nix ];

  options.srodprog.grpc = {
    enable = lib.mkEnableOption "gRPC and protobuf command line tooling";
    go = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Install Go protobuf generators.";
    };
    web = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Install grpc-web protobuf generator.";
    };
  };

  config = lib.mkIf cfg.enable {
    packages =
      with pkgs;
      [
        grpcurl
        protobuf
      ]
      ++ lib.optionals cfg.go [
        protoc-gen-go
        protoc-gen-go-grpc
      ]
      ++ lib.optionals cfg.web [
        protoc-gen-grpc-web
      ];
  };
}
