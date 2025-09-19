# filepath: arithmeval.nix
{
  lib,
  fetchFromGitHub,
  buildPythonPackage,
  setuptools,
  wheel
}:
buildPythonPackage rec {
  pname = "arithmeval";
  version = "unstable";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "enesklcarslan";
    repo = "arithmeval";
    rev = "ae176fca416aa5bab2ab856edede348011f3e1a6";
    hash = "sha256-CUrt3ZFLFR+CDY/brJTLmNv/RuKmX6lPJaa8geXth2Q=";
  };

  nativeBuildInputs = [
    setuptools
    wheel
  ];

  doCheck = false;
  # pythonImportsCheck = [ "arithmeval" ];

  meta = with lib; {
    description = "Arithmetic expression evaluation library (fill in accurate description)";
    homepage = "https://github.com/enesklcarslan/arithmeval";
    license = licenses.bsd3 ; 
    maintainers = [];
    platforms = platforms.all;
  };
}
