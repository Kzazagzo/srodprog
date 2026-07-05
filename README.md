# Środprog

The repository is intentionally narrow:

- `modules/kernel.nix` defines only shared kernel options.
- `modules/profiles/*.nix` provide language and stack presets.
- `modules/integrations/*.nix` provide smaller reusable building blocks.
- `templates/*` are starter projects for `nix flake init`.

## Flake Usage

```nix
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    devenv.url = "github:cachix/devenv";
    srodprog.url = "github:your-user/srodprog";
  };

  outputs = inputs: {
    devenv.shells.default = {
      imports = [
        inputs.srodprog.devenvModules.kernel
        inputs.srodprog.devenvModules.rust
        inputs.srodprog.devenvModules.python-uv
      ];

      srodprog = {
        nixTools.enable = true;
        rust.enable = true;
        pythonUv = {
          enable = true;
          version = "3.12";
          ideVenvSymlink = true;
        };
      };
    };
  };
}
```

## Template Usage

```bash
nix flake init -t github:kzazagzo/srodprog#rust
nix flake init -t github:kzazagzo/srodprog#python-uv
nix flake init -t github:kzazagzo/srodprog#android-rust
```
