{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  poetry-core,
  poetry,
  pythonOlder,
  stdenv,
  tqdm,
  importlib-metadata,
  pytest,
}:
buildPythonPackage rec {
  pname = "docx2pdf";
  version = "0.1.8";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "AlJohri";
    repo = "docx2pdf";
    rev = "aef5cec1d93da629a3727df7d9955804213b7062";
    hash = "sha256-deKqDZtIM9oVH+vo36n2JRIesBnI3bwn5FJ2vPvQwLE=";
  };

  nativeBuildInputs = [poetry-core];
  build-system= [poetry-core];

  propagatedBuildInputs = [
    tqdm
  ];

  doCheck = false;

  pythonImportsCheck = ["docx2pdf"];

  meta = with lib; {
    description = "Convert docx to pdf on Windows or macOS directly using Microsoft Word (must be installed)";
    homepage = "https://github.com/AlJohri/docx2pdf";
    license = licenses.mit;
    maintainers = with maintainers; [];
    platforms = platforms.all;
    # Note: This package requires Microsoft Word to be installed
  };
}
