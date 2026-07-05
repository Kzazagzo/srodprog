{ ... }:
{
  srodprog = {
    enterMessage = "python uv dev env";
    nixTools.enable = true;
    pythonUv = {
      enable = true;
      version = "3.12";
      ideVenvSymlink = true;
    };
  };
}
