{
  pkgs,
  lib,
  stdenv,
  buildPythonPackage,
  fetchFromGitHub,
  arithmeval,
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
  docx2pdf,
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
}:
buildPythonPackage rec {
  pname = "calkit";
  version = "0.30.1";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "calkit";
    repo = "calkit";
    rev = "5602cc709a367d11b9f522655eee2e71f906364c";
    hash = "sha256-PWIK9M4PRyLCTppsgC3O+0MAqhQKfC/PIlJPxmDP4es=";
  };

  nativeBuildInputs = [
    hatchling
  ];

  propagatedBuildInputs = [
    arithmeval
    bibtexparser
    checksumdir
    docx2pdf
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
      # TODO
      ## deptry
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

  dontCheckRuntimeDeps = false;

  postPatch = ''
    substituteInPlace pyproject.toml \
      --replace-fail '"dvc==3.62.0"' '"dvc>=3.62.0"' \
  '';

  meta = with lib; {
    description = "Reproducibility simplified.";
    homepage = "https://calkit.org";
    changelog = "https://github.com/calkit/calkit/releases";
    license = licenses.mit;
    maintainers = with maintainers; [];
    platforms = platforms.all;
  };
}
