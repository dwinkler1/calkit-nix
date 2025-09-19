{
  pkgs,
  lib,
  stdenv,
  buildPythonPackage,
  fetchFromGitHub,
  pythonOlder,
  bibtexparser,
  checksumdir,
  dvc,
  fastapi,
  gitpython,
  keyring,
  nbconvert,
  pillow,
  pydantic,
  pydantic-settings,
  pyjwt,
  python-dotenv,
  requests,
  typer,
  uvicorn,
  tqdm,
  psutil,
  papermill,
  jupyterlab,
  pandas,
  polars,
  ipykernel,
  jupyter,
  kaleido,
  numpy,
  plotly,
  pre-commit,
  pyarrow,
  pytest,
  pytest-cov,
  pytest-test-utils,
  mkdocs,
  mkdocs-material,
  mkdocs-mermaid2-plugin,
  pytest-env,
  hatchling,
  setuptools,
  wheel,
  poetry-core,
}: let
  arithmeval = buildPythonPackage rec {
    pname = "arithmeval";
    version = "unstable";
    format = "pyproject";

    src = fetchFromGitHub {
      owner = "enesklcarslan";
      repo = "arithmeval";
      rev = "8c36b2c801a830138a22cc67274df63080482864";
      hash = "sha256-MKY9tCjY7pHVuX2K5TyWIdg8x7Pd9JJhi6unXBn9MGU=";
    };

    nativeBuildInputs = [
      setuptools
      wheel
    ];

    doCheck = false;
    # Uncomment if the project has an importable top-level module:
    # pythonImportsCheck = [ "arithmeval" ];

    meta = with lib; {
      description = "Arithmetic expression evaluation library (fill in accurate description)";
      homepage = "https://github.com/enesklcarslan/arithmeval";
      # Replace license with the correct one from the repo (e.g. licenses.mit).
      license = licenses.bsd3; # TODO: fix license
      maintainers = [];
      platforms = platforms.all;
    };
  };
in
  buildPythonPackage rec {
    pname = "calkit-python";
    version = "0.30.1";
    format = "pyproject";

    src = fetchFromGitHub {
      owner = "dwinkler1";
      repo = "calkit";
      rev = "8c36b2c801a830138a22cc67274df63080482864";
      hash = "sha256-PWIK9M4PRyLCTppsgC3O+0MAqhQKfC/PIlJPxmDP4es="; # You'll need to add the actual hash after first build
    };

    nativeBuildInputs = [
      hatchling
    ];

    propagatedBuildInputs = [
      arithmeval
      bibtexparser
      checksumdir
      dvc
      fastapi
      gitpython
      keyring
      nbconvert
      pillow
      pydantic
      pydantic-settings
      pyjwt
      python-dotenv
      requests
      typer
      uvicorn
      tqdm
      psutil
      papermill
      jupyterlab
    ];

    passthru.optional-dependencies = {
      data = [
        pandas
        polars
      ];
    };

    passthru.dev-dependencies = {
      dev = [
        #deptry
        ipykernel
        jupyter
        kaleido
        numpy
        pandas
        polars
        plotly
        pre-commit
        pyarrow
        pytest
        pytest-cov
        pytest-test-utils
        mkdocs
        mkdocs-material
        mkdocs-mermaid2-plugin
        pytest-env
      ];
    };

    pythonImportsCheck = ["calkit"];
    dontCheckRuntimeDeps = true;

    meta = with lib; {
      description = "Reproducibility simplified.";
      homepage = "https://calkit.org";
      changelog = "https://github.com/calkit/calkit/releases";
      license = licenses.mit;
      maintainers = with maintainers; [];
      platforms = platforms.all;
    };
  }
