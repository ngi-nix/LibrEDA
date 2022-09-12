inputs: versions: _: final: rec {
  maintainers.svaes = {
    email = "sil.g.vaes@gmail.com";
    matrix = "@egyptian_cowboy:matrix";
    name = "Sil Vaes";
    github = "s-vaes";
    githubId = 8971074;
  };
  
  libreda = {
    splay = (final.callPackage ./splay { }).overrideAttrs (oldAttrs: {
      src = inputs.splay;
      version = versions.splay;
    });

    libreda-db = (final.callPackage ./libreda-db { }).overrideAttrs (oldAttrs: {
      src = inputs.libreda-db;
      version = versions.libreda-db;
    });

    iron-shapes = (final.callPackage ./iron-shapes { }).overrideAttrs (oldAttrs: {
      src = inputs.iron-shapes;
      version = versions.iron-shapes;
    });
  };

  default = libreda.libreda-db;
}
