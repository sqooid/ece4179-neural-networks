{ lib
, buildPythonPackage
, fetchPypi
, setuptools
, wheel
}:

buildPythonPackage rec {
  pname = "torchsummary";
  version = "1.5.1";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-mBv2ieIuDPf5XHRgAvIKJK0mqmudhhE0oUvGzpIjBZA=";
  };

  # do not run tests
  doCheck = false;

  # specific to buildPythonPackage, see its reference
  pyproject = true;
  build-system = [
    setuptools
    wheel
  ];
}
