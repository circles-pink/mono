{
  description = "Circles Pink monorepo";

  inputs.nixpkgs.url = "nixpkgs";

  inputs.purescript-tsd-gen.url = github:thought2/purescript-tsd-gen/flake;

  inputs.flake-utils.url = github:numtide/flake-utils;

  inputs.nix-filter.url = github:numtide/nix-filter;

  inputs.nixops.url = github:NixOS/nixops;

  inputs.circles-pink-vendor.url = github:circles-pink/circles-pink-vendor;

  inputs.easy-purescript-nix = {
    url = github:justinwoo/easy-purescript-nix;
    flake = false;
  };

  inputs.flake-compat = {
    url = github:edolstra/flake-compat;
    flake = false;
  };

  inputs.hercules-ci-effects.url = "github:hercules-ci/hercules-ci-effects";

  inputs.flake-compat-ci.url = "github:hercules-ci/flake-compat-ci";

  inputs.deadnix.url = "github:astro/deadnix";

  inputs.circles-toolbelt = {
    url = "github:CirclesUBI/circles-toolbelt";
    flake = false;
  };

  inputs.circles-docker = {
    url = "github:CirclesUBI/circles-docker";
    flake = false;
  };

  outputs = inputs:
    let
      devSystems = [ "x86_64-linux" "aarch64-darwin" ];
      ciSystems = devSystems;
      cdSystem = "x86_64-linux";
      self = inputs.self;

      system = "x86_64-linux";

      overlays = [
        overlay
        (prev: final: {
          purescript-tsd-gen = purescript-tsd-gen.defaultPackage.${system};
          spago2nix = easy-purescript-nix.spago2nix;
          nix-filter = nix-filter.lib;
          # nodejs = final.nodejs-17_x;
          nixopsLatest = inputs.nixops.defaultPackage.${system};
          circles-pink-vendor = inputs.circles-pink-vendor.packages.${system};
        })
        inputs.deadnix.overlay
      ];

      pkgs = import inputs.nixpkgs {
        inherit system;
        inherit overlays;
      };
      nix-filter = inputs.nix-filter;
      purescript-tsd-gen = inputs.purescript-tsd-gen;
      easy-purescript-nix = import inputs.easy-purescript-nix { inherit pkgs; };
      overlay = import ./nix/overlay.nix;
      checks = import ./nix/checks.nix { inherit pkgs; };

      perSystem = (inputs.flake-utils.lib.eachSystem [ "x86_64-linux" ]
        (system:
          {
            # inherit overlays;

            legacyPackages = { inherit pkgs; } // pkgs.circles-pink;

            packages = {
              ci = pkgs.runCommand "ci" { } ''
                mkdir $out
                # TODO: make generic with a map for all checks
                ln -s ${self.checks.${system}.deploy-nixops-example-prebuilt} $out/deploy-nixops-example-prebuilt
                ln -s ${self.checks.${system}.pursTests} $out/pursTests
              '';

              checkouts = pkgs.runCommand "checkouts" { } ''
                mkdir $out
                cp -R ${inputs.circles-docker} $out/circles-docker
                chmod -R +w $out
                mv $out/circles-docker/.env.example $out/circles-docker/.env
                
                cp -R ${inputs.circles-toolbelt} $out/circles-toolbelt
              '';
            };

            checks = self.packages; # gets overwritten below. todo: change!

            devShell =
              pkgs.mkShell {
                nativeBuildInputs = [
                  pkgs.nixpkgs-fmt
                  pkgs.git
                  pkgs.vscode
                  pkgs.bashInteractive
                  pkgs.yarn
                  pkgs.nix-tree
                  pkgs.miniserve
                  pkgs.nodePackages.node2nix
                  pkgs.nodePackages.purty
                  pkgs.nodePackages.typescript
                  pkgs.nodejs
                  pkgs.purescript
                  pkgs.spago
                  pkgs.purescript-tsd-gen
                  pkgs.spago2nix
                  pkgs.cspell
                  pkgs.ts-node
                  pkgs.circles-pink.patchTsTypes
                  pkgs.gnumake
                  pkgs.fff
                  pkgs.nodePackages.prettier
                  pkgs.dhall
                  pkgs.dhall-lsp-server
                  pkgs.graphviz
                  pkgs.makefile2graph
                  pkgs.depcruise
                  pkgs.nixops
                  pkgs.fish
                  pkgs.graphql-zeus
                  pkgs.signal-desktop
                  pkgs.yarn2nix
                  pkgs.jq
                  #pkgs.virtualboxHeadless
                  pkgs.notify-done
                  pkgs.chokidar-cli
                  pkgs.log-result
                  pkgs.just
                  pkgs.patch-json
                  pkgs.gh
                  pkgs.deadnix
                  (pkgs.circles-pink.bumpNpmVersions (builtins.attrNames pkgs.circles-pink.ts.publicWorkspaces))
                  #nodePackages.webpack
                ];

                # Change the prompt to show that you are in a devShell
                shellHook = ''
                  . ${pkgs.complete-alias}/bin/complete_alias
              
                  REPO_ROOT=$PWD
                  export EDITOR=codium

                  alias code=codium
                  alias mk=make
                  alias cd-root="cd $REPO_ROOT"
              
                  complete -F _complete_alias mk
                  complete -F _complete_alias code

                '' +
                "export PS1='\\e[1;36m@circles.pink\\e[0m:\\e[1;34m`echo $PWD | sed s#'$REPO_ROOT'#*#`\\e[0m$ '";
              };
          }));

      general =
        {

          checks = {
            x86_64-linux =
              let
                effects = self.effects { src.ref = null; };
              in
              {
                deploy-nixops-example-prebuilt = effects.deploy.prebuilt;
                #deploy-nixops-example-dependencies = effects.nixops-example.dependencies;
                #inherit (effects) publish;
              } // checks;
          };

          ciNix = args@{ src }: inputs.flake-compat-ci.lib.recurseIntoFlakeWith {
            flake = self;
            systems = ciSystems;
            effectsArgs = args;
          };

          nixopsConfigurations.default =
            let
              accessKeyId = "nixops-example";
              region = "us-east-1";
              tags = { };
              name = "default";
            in
            {
              nixpkgs = inputs.nixpkgs;
              network.description = name;

              network = {
                storage.memory = { };
              };

            }
            // (import ./networks/prod.nix { inherit pkgs; });

          effects = { src }:
            let
              nixpkgs = inputs.nixpkgs.legacyPackages.${cdSystem};
              effects = inputs.hercules-ci-effects.lib.withPkgs pkgs;
            in
            {
              deploy = effects.runIf (src.ref == "refs/heads/main")
                (effects.runNixOps2
                  {
                    flake = self;

                    userSetupScript = ''
                      writeSSHKey
                      ssh -o "StrictHostKeyChecking no" root@circles.pink whoami
                      mkdir -p ~/.config/nix
                      echo 'experimental-features = nix-command flakes' >>~/.config/nix/nix.conf
                      readSecretJSON secrets . > /secrets.json
                    '';

                    secretsMap = {
                      "ssh" = "default-ssh";
                      "secrets" = "secrets";
                    };
                    forgetState = true;

                  });
              publish = effects.runIf (src.ref == "refs/heads/main")
                (effects.mkEffect {
                  userSetupScript = ''
                    NODE_AUTH_TOKEN=`readSecretString secrets '."npm-token"'`;
                    ${pkgs.nodePackages.npm}/bin/npm config set "//registry.npmjs.org/:_authToken" "$NODE_AUTH_TOKEN"
                  '';

                  effectScript =
                    let
                      pkgJsonUrl = "https://raw.githubusercontent.com/circles-pink/circles-pink/main/package.json";
                      publish = pkgs.writeBashScriptBin "publish" ''
                        DIR="$1"  
                        ${pkgs.nodePackages.npm}/bin/npm publish --verbose --access public $DIR/
                      '';
                      inherit (pkgs.circles-pink.ts) publicWorkspaces;
                    in
                    ''
                      CURRENT_VERSION=`${pkgs.curl}/bin/curl ${packageJsonUrl} | ${pkgs.jq}/bin/jq '.version'`
                      NEW_VERSION=`cat ${./package.json} | ${pkgs.jq}/bin/jq '.version'`
                    
                      if [ "$CURRENT_VERSION" == "$NEW_VERSION" ]
                        then
                          echo "Nothing to release."
                          exit 0
                      fi

                      ${concatMapStringsSep "\n" (ws: "${publish}/bin/publish ws") publicWorkspaces}    
                    '';

                  secretsMap = {
                    "secrets" = "secrets";
                  };
                });
            };
        };

    in
    perSystem // general;
}
