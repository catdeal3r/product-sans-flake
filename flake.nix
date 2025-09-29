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
        packages.default = pkgs.runCommand "product-sans" {} ''
          mkdir -p $out/share/fonts
          mkdir -p $out/share/fonts/truetype
          find -name \*.ttf -exec mv {} $out/share/fonts/truetype/ \;
        '';
      };
   };
}

