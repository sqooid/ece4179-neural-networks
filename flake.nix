{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
  };
  outputs = { self, nixpkgs, ... }:
    let
      forSystem = nixpkgs.lib.genAttrs [
        "x86_64-linux"
        "aarch64-darwin"
      ];
      pkgsFor = forSystem (system:
        import nixpkgs { inherit system; }
      );
    in
    {
      packages = forSystem
        (system:
          let
            pkgs = pkgsFor."${system}";
          in
          {
            # app = pkgs.callPackage ./path { };
          }
        );
      devShells = forSystem
        (system:
          let
            pkgs = pkgsFor."${system}";
            pp = ps: with ps; [
              jupyterlab
              opencv4
              torch
              torchaudio
              torchvision
              pytorch-lightning
              torchmetrics
              numpy
              matplotlib
              scipy
              numba
              ipywidgets
              ipython
              librosa
              scikit-image
              scikit-learn
              pillow
              transformers
              imageio
              pandas
              lightning
              torchsummary
              tensorboard
            ];
            python = pkgs.python312.override {
              self = python;
              packageOverrides = pyfinal: pyprev: {
                lightning = pyfinal.callPackage ./lightning.nix { };
                torchsummary = pyfinal.callPackage ./torchsummary.nix { };
              };
            };
          in
          {
            default = pkgs.mkShell {
              buildInputs = with pkgs; [ (python.withPackages pp) ];
            };
          }
        );
    };
}
