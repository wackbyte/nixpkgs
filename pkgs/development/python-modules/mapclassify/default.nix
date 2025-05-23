{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  pytestCheckHook,
  pythonOlder,

  geopandas,
  libpysal,
  matplotlib,
  networkx,
  numpy,
  pandas,
  scikit-learn,
  scipy,
  setuptools-scm,
}:

buildPythonPackage rec {
  pname = "mapclassify";
  version = "2.8.1";
  pyproject = true;
  disabled = pythonOlder "3.9";

  src = fetchFromGitHub {
    owner = "pysal";
    repo = "mapclassify";
    tag = "v${version}";
    hash = "sha256-VClkMOR8P9sX3slVjJ2xYYLVnvZuOgVYZiCGrBxoZEc=";
  };

  build-system = [ setuptools-scm ];

  propagatedBuildInputs = [
    networkx
    numpy
    pandas
    scikit-learn
    scipy
  ];

  nativeCheckInputs = [
    pytestCheckHook
    geopandas
    libpysal
    matplotlib
  ];

  # requires network access
  disabledTestPaths = [
    "mapclassify/tests/test_greedy.py"
    "mapclassify/tests/test_rgba.py"
    # Abort trap: 6
    "mapclassify/tests/test_mapclassify.py"
  ];

  pythonImportsCheck = [ "mapclassify" ];

  meta = {
    description = "Classification Schemes for Choropleth Maps";
    homepage = "https://pysal.org/mapclassify/";
    changelog = "https://github.com/pysal/mapclassify/releases/tag/v${version}";
    license = lib.licenses.bsd3;
    teams = [ lib.teams.geospatial ];
  };
}
