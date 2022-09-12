{ fetchgit, rustPlatform, ... } @ args:
rustPlatform.buildRustPackage {
  name = "splay";
  version = "0.0.1";
  src = fetchgit {
    url = "https://codeberg.org/LibrEDA/splay";
    
    # sparseCheckout = ''
    #   path/to/be/included
    #   another/path
    # '';
    sha256 = "0bnr28vbhwp52czdbwyjjr6lahgrfjkp93ksdz88f33zrl7gzq3c";
  };
  cargoSha256 = "5G5eO4hgIngFWIlY54jSzl/y8XkXqKIsqvIjEaVwlWk=";

  cargoPatches = [
    # a patch file to add/update Cargo.lock in the source code
    ./lockfile.patch
  ];
  # Add extra inputs here or any other derivation settings
  # doCheck = true;
  # buildInputs = [];
  # nativeBuildInputs = [];
}
