{ lib, stdenv, fetchFromGitHub, fetchpatch, cmake, ffmpeg, SDL2, chromaprint, libebur128 }:

stdenv.mkDerivation rec {
  version = "4.3.0";
  pname = "libgroove";

  src = fetchFromGitHub {
    owner = "andrewrk";
    repo = "libgroove";
    rev = version;
    sha256 = "1la9d9kig50mc74bxvhx6hzqv0nrci9aqdm4k2j4q0s1nlfgxipd";
  };

  patches = [
    ./no-warnings-as-errors.patch
    ./update-for-ffmpeg-4.0.patch
  ];

  nativeBuildInputs = [ cmake ];
  buildInputs = [ ffmpeg SDL2 chromaprint libebur128 ];

  meta = with lib; {
    description = "Streaming audio processing library";
    homepage = "https://github.com/andrewrk/libgroove";
    license = licenses.mit;
    platforms = platforms.unix;
    maintainers = with maintainers; [ andrewrk ];
  };
}
