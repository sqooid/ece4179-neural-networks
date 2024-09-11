{ lib
, buildPythonPackage
, fetchPypi
, setuptools
, wheel
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

  # specific to buildPythonPackage, see its reference
  pyproject = true;
  build-system = [
    setuptools
    wheel
  ];
}
