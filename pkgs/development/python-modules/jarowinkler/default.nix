{ lib
, buildPythonPackage
, pythonOlder
, fetchFromGitHub
, cmake
, ninja
, cython
, rapidfuzz-capi
, scikit-build
, setuptools
, jarowinkler-cpp
, hypothesis
, pytestCheckHook
}:

buildPythonPackage rec {
  pname = "jarowinkler";
  version = "1.1.0";

  disabled = pythonOlder "3.6";

  format = "pyproject";

  src = fetchFromGitHub {
    owner = "maxbachmann";
    repo = "JaroWinkler";
    rev = "v${version}";
    hash = "sha256-ilkslDrTOaq6mgg+nYMMqxrjvZHXMIcipu25wvV3+Mk=";
  };

  nativeBuildInputs = [
    cmake
    cython
    ninja
    rapidfuzz-capi
    scikit-build
    setuptools
  ];

  buildInputs = [
    jarowinkler-cpp
  ];

  preBuild = ''
    export JAROWINKLER_BUILD_EXTENSION=1
  '';

  dontUseCmakeConfigure = true;

  checkInputs = [
    hypothesis
    pytestCheckHook
  ];

  pythonImportsCheck = [ "jarowinkler" ];

  meta = with lib; {
    description = "Library for fast approximate string matching using Jaro and Jaro-Winkler similarity";
    homepage = "https://github.com/maxbachmann/JaroWinkler";
    changelog = "https://github.com/maxbachmann/JaroWinkler/blob/${src.rev}/CHANGELOG.md";
    license = licenses.mit;
    maintainers = with maintainers; [ dotlambda ];
  };
}
