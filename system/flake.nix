{

  description = "A crude edition of deployOS";


  inputs.flake-utils.url = "github:numtide/flake-utils";


  outputs = { self, nixpkgs, flake-utils }:

    flake-utils.lib.eachDefaultSystem (system:

      let

        pkgs = import nixpkgs { inherit system; };

        my-name = "deos";

        my-buildInputs = with pkgs; [ ];

        deos = (pkgs.writeScriptBin my-name (builtins.readFile ./deos.sh)).overrideAttrs(old: {

          buildCommand = "${old.buildCommand}\n patchShebangs $out";

        });

      in rec {

        defaultPackage = packages.deos;

        packages.deos = pkgs.symlinkJoin {

          name = my-name;

          paths = [ deos ] ++ my-buildInputs;

          buildInputs = [ pkgs.makeWrapper ];

          postBuild = "wrapProgram $out/bin/${my-name} --prefix PATH : $out/bin";

        };

      }

    );

}