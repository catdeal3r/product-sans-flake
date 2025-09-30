{
  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    product-sans-source = {
      url = "https://befonts.com/wp-content/uploads/2018/08/product-sans.zip";
      flake = false;
    };
  };

  outputs = { flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "x86_64-darwin"
        "aarch64-linux"
        "aarch64-darwin"
      ];

      perSystem = { pkgs, ... }: {
        packages =
          let
            makeFont =
              name: src:
              pkgs.stdenv.mkDerivation {
                inherit name src;
                version = "0.1.0";

                unpackPhase = ''
                  echo ${src}      
                '';
              
                buildInputs = [
                  pkgs.unzip
                ];

                setSourceRoot = "sourceRoot=`pwd`";

                installPhase = ''
                  mkdir -p $out/share/fonts
                  mkdir -p $out/share/fonts/truetype
                  find ${src} -name \*.ttf -exec mv {} $out/share/fonts/truetype/ \;
                '';
              };
          in
          {
            default = makeFont "product-sans" (inputs.product-sans-source);
          };
      };
   };
}

