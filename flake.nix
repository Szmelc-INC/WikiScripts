{
  description = "Scripts, scrapers and CLI tools for scripting Wikipedia.org";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});
      runtime = pkgs: with pkgs; [ curl wget file gnused gnugrep coreutils ];
    in
    {
      packages = forAllSystems (pkgs: rec {
        wikiscripts = pkgs.stdenvNoCC.mkDerivation {
          pname = "wikiscripts";
          version = "0-unstable-${self.shortRev or self.dirtyShortRev or "dirty"}";
          src = ./.;
          nativeBuildInputs = [ pkgs.makeWrapper ];
          dontBuild = true;
          installPhase = ''
            runHook preInstall
            sed -i 's|bash download-article-in-pdf.sh|wiki-pdf|' random-article.sh
            install -Dm755 random.sh $out/bin/wiki-random
            install -Dm755 random-article.sh $out/bin/wiki-random-article
            install -Dm755 download-article-in-pdf.sh $out/bin/wiki-pdf
            install -Dm755 file-details.sh $out/bin/wiki-file-details
            patchShebangs $out/bin
            for f in $out/bin/*; do
              wrapProgram $f --prefix PATH : $out/bin:${pkgs.lib.makeBinPath (runtime pkgs)}
            done
            install -Dm644 README.md -t $out/share/doc/wikiscripts
            runHook postInstall
          '';
          meta = {
            description = "Scripts, scrapers and CLI tools for scripting Wikipedia.org";
            homepage = "https://github.com/Szmelc-INC/WikiScripts";
            license = pkgs.lib.licenses.mit;
            mainProgram = "wiki-random-article";
            platforms = pkgs.lib.platforms.unix;
          };
        };
        default = wikiscripts;
      });

      apps = forAllSystems (pkgs: {
        default = {
          type = "app";
          program = "${self.packages.${pkgs.stdenv.hostPlatform.system}.default}/bin/wiki-random-article";
        };
      });

      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShell { packages = runtime pkgs ++ [ pkgs.shellcheck ]; };
      });
    };
}
