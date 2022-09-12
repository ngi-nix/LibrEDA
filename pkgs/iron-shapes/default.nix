{ fetchgit, rustPlatform, ... } @ args:
rustPlatform.buildRustPackage {
  name = "iron-shapes";
  version = "0.0.1";
  src = fetchgit {
    url = "https://codeberg.org/LibrEDA/iron-shapes";
    
    # sparseCheckout = ''
    #   path/to/be/included
    #   another/path
    # '';
    sha256 = "16xz69xi707kmdklp037bxjczbiyh0hvbzbjvns22fmqpar0mp4b";
  };
  cargoSha256 = "";

  cargoPatches = [
    # a patch file to add/update Cargo.lock in the source code
    ./lockfile.patch
  ];
  # Add extra inputs here or any other derivation settings
  # doCheck = true;
  # buildInputs = [];
  # nativeBuildInputs = [];
}
