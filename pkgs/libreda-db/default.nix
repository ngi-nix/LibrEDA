{ fetchgit, rustPlatform, ... } @ args:
rustPlatform.buildRustPackage {
  name = "libreda-db";
  version = "0.0.1";
  src = fetchgit {
    url = "https://codeberg.org/LibrEDA/libreda-db";
    
    # sparseCheckout = ''
    #   path/to/be/included
    #   another/path
    # '';
    sha256 = "0dq4ya2111vh5fygy7mhnywhfnqir61gywn7wc17bg3nfdafybp4";
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
