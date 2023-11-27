{

  description = "HomeManager switch at the user level";


  outputs = { self, nixpkgs }: {

    defaultPackage.x86_64-linux = self.packages.x86_64-linux.deployOS;


    packages.x86_64-linux.deployOS =

      let

        pkgs = import nixpkgs { system = "x86_64-linux"; };


        my-name = "deployOS";

        deployOS = pkgs.writeShellScriptBin my-name ''
          echo " "
          echo "###"
          echo "# deployOS is switching users home settings..."
          echo "###"
          echo " "
          home-manager switch
        '';

        my-buildInputs = with pkgs; [ ];

      in pkgs.symlinkJoin {

        name = my-name;

        paths = [ deployOS ] ++ my-buildInputs;

        buildInputs = [ pkgs.makeWrapper ];

        postBuild = "wrapProgram $out/bin/${my-name} --prefix PATH : $out/bin";

      };

  };

}

