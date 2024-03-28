{pkgs,stdenv,...}: 
let
  files = [
    {
      name = "d3.js";
      url = "https://d3js.org/d3.v7.min.js";
      hash = "sha256-8glLv2FBs1lyLE/kVOtsSw8OQswQzHr5IfwVj864ZTk=";
    }
    {
      name = "htmx.js";
      url = "https://unpkg.com/htmx.org@1.9.11/dist/htmx.min.js";
      hash = "sha256-0VEHzH8ECp6DsbZhdv2SetQLXgJVgToD+Mz+7UbuQrA=";
    }
    {
      name = "htmx-sse.js";
      url = "https://unpkg.com/htmx.org@1.9.11/dist/ext/sse.js";
      hash = "sha256-vgWy4iZSefA1Jxrb6gtyo1byDOTfpYcEgb/pxRuCL8E=";
    }
  ];
  staticsPath = "\$(${pkgs.git}/bin/git rev-parse --show-toplevel)/static";
  

in
{
  fetch = pkgs.symlinkJoin {
    name = "all";
    paths = ( (map (lib: pkgs.writeTextFile {
        name = "${lib.name}";
        text = builtins.readFile ( pkgs.fetchurl {
        # Why'd I have to do it like this?
          url = "${lib.url}";
          hash = "${lib.hash}";
        } );
        destination = "/bin/${lib.name}";
      }) files) ++ [
        (pkgs.writeScriptBin "symlinks" (
          "if [ ! -d \"${staticsPath}\" ]; then mkdir ${staticsPath}; fi;\n" +
          builtins.concatStringsSep "\n" (  map (
            lib: "ln -sfn \$(dirname \$0)/${lib.name} ${staticsPath}/${lib.name};"
          # replace readlink with something nixy.
          ) files )
          ))
      ]
    ); 
  };
  /*
  symlink = pkgs.writeShellApplication { 
    name = "symlink";
    text = (
      "mkdir ${staticsPath};\n" +
      builtins.concatStringsSep "\n" (  map (
      lib: "ln ${fetch}/bin/${lib.name} ${staticsPath}/${lib.name};"
      ) files )
    );
  }; */
  


}
