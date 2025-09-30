# product-sans-flake
A flake providing the Product Sans font.

Usage:

1. Add to flake.nix
```nix
product-sans-font.url = "github:catdeal3r/product-sans-flake";
```

2. Use in other modules
```nix
inputs.product-sans-font.packages.${pkgs.system}.default
```

E.g.
```nix
fonts.packages = with pkgs; [
  inputs.product-sans-font.packages.${pkgs.system}.default
];
```

