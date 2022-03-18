{ pkgs, pursOutput, assets, ... }: rec {

  localPackages = {
    dev-utils = ../../pkgs/ts/dev-utils;
    common = ../../pkgs/ts/common;
    storybook = ../../pkgs/ts/storybook;
    cli = ../../pkgs/ts/cli;
    circles = ../../pkgs/ts/circles;
    circles-directus = ../../pkgs/ts/circles-directus;
    generated = ../../pkgs/ts/generated;
    assets = ../../pkgs/ts/assets;
    # cli-playground = ../../pkgs/ts/cli-playground;
  };

  src = pkgs.nix-filter.filter {
    root = ../../.;
    include = [
      "package.json"
      "yarn.lock"
    ] ++ (
      pkgs.lib.pipe localPackages [
        builtins.attrNames
        (map (name: "pkgs/ts/${name}/package.json"))
      ]
    )
    ;
  };

  emptyWorkspaces = pkgs.yarn2nix-moretea.mkYarnWorkspace {
    inherit src;
  };

  replaceEmptyLocalDep = pkgName: pkgs.lib.pipe localPackages [
    (pkgs.lib.mapAttrsToList (depName: drv: ''
      dir="$tmp/libexec/${pkgName}/deps/${depName}"
      if [ -d $dir ];
      then
        tmpNodeModules=`mktemp -d`
        
        if [ -d "$dir/node_modules/" ];
          then cp -r $dir/node_modules/ $tmpNodeModules/node_modules
        fi
        
        rm -rf $dir
        cp -r ${drv} $dir
        chmod +w $dir
        rm -rf $dir/node_modules
        
        if [ -d "$tmpNodeModules/node_modules" ];
          then cp -r $tmpNodeModules/node_modules $dir/node_modules
          else cp -rf $dir/../../node_modules $dir/node_modules
        fi
      fi
    ''))
    (builtins.concatStringsSep "\n")
  ];

  workspaces =
    builtins.mapAttrs
      (name: value: pkgs.runCommand "" { } ''
        tmp=`mktemp -d`
        cp -r ${value}/* -t $tmp
        chmod -R +w $tmp

        ${replaceEmptyLocalDep name}

        cp -r $tmp $out
      '')
      emptyWorkspaces;

  bins = {
    depcruise = pkgs.writeShellScriptBin "depcruise" ''
      ${workspaces.dev-utils}/libexec/dev-utils/node_modules/dependency-cruiser/bin/dependency-cruise.js $@
    '';

    circles-directus =
      let
        dir_patched = pkgs.runCommand "dir_patched" { } ''
          mkdir $out
          cp -r ${workspaces.circles-directus}/* -t $out
          chmod -R +w $out
          cp -r ${pkgs.circles-pink-vendor.argon2}/* -t $out/libexec/circles-directus/node_modules/argon2
          cp -r ${pkgs.circles-pink-vendor.sharp}/* -t $out/libexec/circles-directus/node_modules/sharp
        '';
      in
      pkgs.writeShellScriptBin "circles-directus" ''
        export HOST="0.0.0.0"
        export PORT=8055
        export PUBLIC_URL="http://localhost:8055"
        export LOG_LEVEL="info"
        export LOG_STYLE="pretty"

        export DB_CLIENT="mysql"
        export DB_HOST="localhost"
        export DB_PORT=5100
        export DB_DATABASE="directus"
        export DB_USER="directus"
        export DB_PASSWORD="secret"

        export KEY="xxxxxxx-xxxxxx-xxxxxxxx-xxxxxxxxxx"
        export SECRET="abcdef"
        export ACCESS_TOKEN_TTL="15m"
        export REFRESH_TOKEN_TTL="7d"
        export REFRESH_TOKEN_COOKIE_SECURE="false"
        export REFRESH_TOKEN_COOKIE_SAME_SITE="lax"
        export REFRESH_TOKEN_COOKIE_NAME="directus_refresh_token"

        cd ${dir_patched}/libexec/circles-directus/node_modules/directus
        ./cli.js $@
      '';
  };

  builds = {
    storybook = pkgs.runCommand "storybook" { buildInputs = [ pkgs.yarn ]; } ''

  ############ Create clean ts node package in temp dir

      tmp=`mktemp -d`
      mkdir -p $tmp/pkgs/ts

      cp ${../../package.json} $tmp/package.json
      chmod -R +w $tmp

  ############ Copy storybook src from pkgs
    
      cp -r ${../../pkgs/ts/storybook} $tmp/pkgs/ts/storybook
      chmod -R +w $tmp

  ############ Copy storybook deps from yarn2nix build

      cp -r ${workspaces.storybook}/libexec/storybook/node_modules $tmp/node_modules
      chmod -R +w $tmp

  ############ Replace circles deps with deps from yarn2nix build

      rm -rf $tmp/node_modules/circles
      cp -r ${workspaces.storybook}/libexec/storybook/deps/circles $tmp/node_modules/circles
      chmod -R +w $tmp

  ############ Copy purescript output to circles deps

      mkdir -p $tmp/node_modules/circles/node_modules/generated
      cp -r ${pursOutput} $tmp/node_modules/circles/node_modules/generated/output
      chmod -R +w $tmp

  ############ Replace assets package with nix build assets

      rm $tmp/node_modules/assets
      mkdir -p $tmp/node_modules/assets
      cp -r ${assets} $tmp/node_modules/assets/src
      chmod -R +w $tmp

  ############ Replace generated package with purescript output

      rm $tmp/node_modules/generated
      mkdir -p $tmp/node_modules/generated
      cp -r ${pursOutput} $tmp/node_modules/generated/output
      chmod -R +w $tmp

  ############ Copy generated deps from yarn2nix build

      mkdir -p $tmp/node_modules/generated/node_modules/@circles
      cp -r ${workspaces.generated}/libexec/generated/deps/generated/node_modules/@circles/core \
       $tmp/node_modules/generated/node_modules/@circles
      chmod -R +w $tmp

      mkdir -p $tmp/node_modules/circles/node_modules/generated/node_modules/@circles
      cp -r ${workspaces.generated}/libexec/generated/deps/generated/node_modules/@circles/core \
       $tmp/node_modules/circles/node_modules/generated/node_modules/@circles
      chmod -R +w $tmp

  ############ Replace storybook deps with deps from yarn2nix build

      cp -r ${workspaces.storybook}/libexec/storybook/deps/storybook/node_modules/ \
        $tmp/pkgs/ts/storybook/node_modules
      chmod -R +w $tmp

  ############ Build storybook and write to $out

      cd $tmp
      export OUTPUT_DIR=$tmp/dist; yarn workspace storybook run build
      chmod -R +w $tmp

      cp -r $tmp/dist $out

    '';
  };

}
