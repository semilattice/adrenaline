{pkgs ? import ./support/pkgs.nix {}}:
pkgs.callPackage ./adrenaline.nix {}
