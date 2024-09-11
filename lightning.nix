{ lib
, buildPythonPackage
, fetchPypi
, setuptools
, wheel
, pkgs
}:

buildPythonPackage rec {
  pname = "lightning";
  version = "2.4.0";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-kVZgTMVuSytgPzT6fw/lEHN1yObYXnRUSzGaFfqp7Q4=";
  };

  # do not run tests
  doCheck = false;

  propagatedBuildInputs = with pkgs.python312Packages; [
    pyyaml
    fsspec
    lightning-utilities
    torch
    torchmetrics
    tqdm
    typing-extensions
    pytorch-lightning
  ];

  # specific to buildPythonPackage, see its reference
  pyproject = true;
  build-system = [
    setuptools
    wheel
  ];
}
