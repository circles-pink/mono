# This file was generated by Spago2Nix

{ pkgs ? import <nixpkgs> {} }:

let
  inputs = {

    "aff" = pkgs.stdenv.mkDerivation {
        name = "aff";
        version = "v6.0.0";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript-contrib/purescript-aff.git";
          rev = "d0eb009f2f47cb1f5ba1d8592d90c95e8e7ff75d";
          sha256 = "1780sgqyvbdgh8ynxmxn5d44vvhaz7kn9sv3l44c2s9q8xfjkfgm";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "ansi" = pkgs.stdenv.mkDerivation {
        name = "ansi";
        version = "v6.1.0";
        src = pkgs.fetchgit {
          url = "https://github.com/hdgarrood/purescript-ansi.git";
          rev = "e89e6fede616bd16b001841cf30ac320c95313a6";
          sha256 = "1jsll0h7nz13zgscs036cnkkc6frnlcnk6fwjdwsyp6wbmjri2zm";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "arraybuffer-types" = pkgs.stdenv.mkDerivation {
        name = "arraybuffer-types";
        version = "v3.0.1";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript-contrib/purescript-arraybuffer-types.git";
          rev = "48cd7f4887791db1d9c2daf5fd98b62ba00e15bd";
          sha256 = "09r6bhsiq9iqdsjf9p8m3p31qkszsipsafvy836mfdi8af6h5fv6";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "arrays" = pkgs.stdenv.mkDerivation {
        name = "arrays";
        version = "v6.0.1";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript/purescript-arrays.git";
          rev = "c0aa3176b077ad7a46b11ef34487485c28142e53";
          sha256 = "0lm0m5hapimchzgfywr648pkw1hpggr6qibh8d19p2impbnc94c0";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "avar" = pkgs.stdenv.mkDerivation {
        name = "avar";
        version = "v4.0.0";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript-contrib/purescript-avar.git";
          rev = "ac3cbbb8d4b71ff19a78a3178355c089e44d3b4d";
          sha256 = "005046wl61w6r5v3qwd16srhcx82vdz3yvp4xzad2xaasb6iq55l";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "bifunctors" = pkgs.stdenv.mkDerivation {
        name = "bifunctors";
        version = "v5.0.0";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript/purescript-bifunctors.git";
          rev = "a31d0fc4bbebf19d5e9b21b65493c28b8d3fba62";
          sha256 = "0xc2hf8ccdgqw3m9qcmr38kmzv05fsxvakd07wyrqshvkzg3xn0d";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "catenable-lists" = pkgs.stdenv.mkDerivation {
        name = "catenable-lists";
        version = "v6.0.1";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript/purescript-catenable-lists.git";
          rev = "ee03395f2c5d59a7fd8529a0faac6ec1ebcbb682";
          sha256 = "1lz06fx0za5sl65wccn5fl37mw3x4jnvrriz1gg0aqsmm9lag7ss";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "console" = pkgs.stdenv.mkDerivation {
        name = "console";
        version = "v5.0.0";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript/purescript-console.git";
          rev = "d7cb69ef8fed8a51466afe1b623868bb29e8586e";
          sha256 = "0fzzzqjgrz33pb2jf7cdqpg09ilxb7bsrc7sbfq52wjg0sx9aq6g";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "const" = pkgs.stdenv.mkDerivation {
        name = "const";
        version = "v5.0.0";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript/purescript-const.git";
          rev = "3a3a4bdc44f71311cf27de9bd22039b110277540";
          sha256 = "0aq9qjbrvf8mf8hmas6imv4mg6n3zi13hkf449ns1hn12lw8qv4g";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "contravariant" = pkgs.stdenv.mkDerivation {
        name = "contravariant";
        version = "v5.0.0";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript/purescript-contravariant.git";
          rev = "ae1a765f7ddbfd96ae1f12e399e46d554d8e3b38";
          sha256 = "029hb8i3n4759x4gc06wkfgr7wim5x1w5jy2bsiy42n0g731h5qc";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "control" = pkgs.stdenv.mkDerivation {
        name = "control";
        version = "v5.0.0";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript/purescript-control.git";
          rev = "18d582e311f1f8523f9eb55fb93c91bd21e22837";
          sha256 = "06dc06yli4g5yr8fb9sdpqbhiaff37g977qcsbds9q2mlhnjgfx9";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "datetime" = pkgs.stdenv.mkDerivation {
        name = "datetime";
        version = "v5.0.2";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript/purescript-datetime.git";
          rev = "e110462829ea656d2bc0924266d4edff222108d4";
          sha256 = "1mhzn2ymdkzki7wjlr9xrdbngm0886wmfbh2c46flnf9lmfyw54y";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

  # debug-extra is a Local package in (Local "./../../../pkgs/purs/debug-extra")

    "distributive" = pkgs.stdenv.mkDerivation {
        name = "distributive";
        version = "v5.0.0";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript/purescript-distributive.git";
          rev = "11f3f87ca5720899e1739cedb58dd6227cae6ad5";
          sha256 = "0788znmdyh6b1c9pln624ah397l88xmd3fxlxiy3z1qy8bzr4r54";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "effect" = pkgs.stdenv.mkDerivation {
        name = "effect";
        version = "v3.0.0";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript/purescript-effect.git";
          rev = "985d97bd5721ddcc41304c55a7ca2bb0c0bfdc2a";
          sha256 = "1n9qr85knvpm4i0qhm8xbgfk46v9y843p76j278phfs9l6aywzsn";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "either" = pkgs.stdenv.mkDerivation {
        name = "either";
        version = "v5.0.0";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript/purescript-either.git";
          rev = "c1a1af35684f10eecaf6ac7d38dbf6bd48af2ced";
          sha256 = "18dk159yyv7vs0xsnh9m5fajd7zy6zw5b2mpyd6nqdh3c6bb9wh6";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "enums" = pkgs.stdenv.mkDerivation {
        name = "enums";
        version = "v5.0.0";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript/purescript-enums.git";
          rev = "170d959644eb99e0025f4ab2e38f5f132fd85fa4";
          sha256 = "1lci5iy6s6cmh93bpkfcmp0j4n5dnij7dswb0075bk0kzd9xp7rs";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "exceptions" = pkgs.stdenv.mkDerivation {
        name = "exceptions";
        version = "v5.0.0";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript/purescript-exceptions.git";
          rev = "410d0b8813592bda3c25028540eeb2cda312ddc9";
          sha256 = "1yjbrx34a0rnxgpvywb63n9jzhkdgb2q2acyzbwh290mrrggc95x";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "exists" = pkgs.stdenv.mkDerivation {
        name = "exists";
        version = "v5.1.0";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript/purescript-exists.git";
          rev = "c34820f8b2d15be29abdd5097c3d636f5df8f28c";
          sha256 = "15qp52cpp2yvxihkzfmn6gabyvx5s6iz5lafvqhyfgp4wfnz0bds";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "foldable-traversable" = pkgs.stdenv.mkDerivation {
        name = "foldable-traversable";
        version = "v5.0.1";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript/purescript-foldable-traversable.git";
          rev = "d581caf260772b1b446c11ac3c8be807b290b220";
          sha256 = "182na4np7hk2dqyxywy4jij2csrzx4bz02m6bq8yx1j27hlgjvsd";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "foreign" = pkgs.stdenv.mkDerivation {
        name = "foreign";
        version = "v6.0.1";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript/purescript-foreign.git";
          rev = "7ee18c6689c56c89755172ea53326f948da10bd3";
          sha256 = "16j7712cck79p8q53xbhn4hs886bm0ls5wvmchrhqnaghj48m85g";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "foreign-object" = pkgs.stdenv.mkDerivation {
        name = "foreign-object";
        version = "v3.0.0";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript/purescript-foreign-object.git";
          rev = "c9a7b7bb8bed1b87c5545c4ebe85a70f86c0e6b1";
          sha256 = "0accw6qd93qqry19rskjgl7y54xi2wd70rglbqyjx6c5ybcjnavr";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "fork" = pkgs.stdenv.mkDerivation {
        name = "fork";
        version = "v5.0.0";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript-contrib/purescript-fork.git";
          rev = "153cc29e6e51fb1108368efc622d41d9f80bd707";
          sha256 = "1hyvaixza8151zbylk2kv859x48yyhla536lcjghcwd62vzfwmdn";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "free" = pkgs.stdenv.mkDerivation {
        name = "free";
        version = "v6.2.0";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript/purescript-free.git";
          rev = "c185c0b2144ddfb2bc3ac2b345df32e33221b21d";
          sha256 = "10zsw49wzlzz78882b3grl19gpca5llpdk3ph608075h0ygk3q3k";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "functions" = pkgs.stdenv.mkDerivation {
        name = "functions";
        version = "v5.0.0";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript/purescript-functions.git";
          rev = "691b3345bc2feaf914e5299796c606b6a6bf9ca9";
          sha256 = "1gnk6xh5x04zcahn82gwp49qpglxd5jkfqn0i58m27jfihvblaxd";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "functors" = pkgs.stdenv.mkDerivation {
        name = "functors";
        version = "v4.1.1";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript/purescript-functors.git";
          rev = "e936f7a8d2ec53a344c478ccada5add93273848c";
          sha256 = "0i1x14r54758s5jx5d7zy4l07mg6gabljadgybldnbpmdqk6b966";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "gen" = pkgs.stdenv.mkDerivation {
        name = "gen";
        version = "v3.0.0";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript/purescript-gen.git";
          rev = "85c369f56545a3de834b7e7475a56bc9193bb4b4";
          sha256 = "1h396rqn1fc2c155i58vnaksqjrpajly128ah6wq1w426vwr1vrf";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "identity" = pkgs.stdenv.mkDerivation {
        name = "identity";
        version = "v5.0.0";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript/purescript-identity.git";
          rev = "5c150ac5ee4fa6f145932f6322a1020463dae8e9";
          sha256 = "0a58y71ihvb5b7plnn2sxsbphqzd9nzfafak4d5a576agn76q0ql";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "integers" = pkgs.stdenv.mkDerivation {
        name = "integers";
        version = "v5.0.0";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript/purescript-integers.git";
          rev = "8a783f2d92596c43afca53066ac18eb389d15981";
          sha256 = "1rrygw0ai61brnvgap7dfhdzacyhg5439pz6yrmmyg32cvf0znhv";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "invariant" = pkgs.stdenv.mkDerivation {
        name = "invariant";
        version = "v5.0.0";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript/purescript-invariant.git";
          rev = "c421b49dec7a1511073bb408a08bdd8c9d17d7b1";
          sha256 = "0vwkbh7kv00g50xjgvxc0mv5b99mrj6q0sxznxwk32hb9hkbhy5l";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "js-date" = pkgs.stdenv.mkDerivation {
        name = "js-date";
        version = "v7.0.0";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript-contrib/purescript-js-date.git";
          rev = "a6834eef986e3af0490cb672dc4a8b4b089dcb15";
          sha256 = "1dpiwn65qww862ilpfbd06gwfazpxvz3jwvsjsdrcxqqfcbjp8n8";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "lazy" = pkgs.stdenv.mkDerivation {
        name = "lazy";
        version = "v5.0.0";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript/purescript-lazy.git";
          rev = "2f73f61e7ac1ae1cfe05564112e3313530e673ff";
          sha256 = "1wxfx019911gbkifq266hgn67zwm89pxhi83bai77mva5n9j3f6l";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "lcg" = pkgs.stdenv.mkDerivation {
        name = "lcg";
        version = "v3.0.0";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript/purescript-lcg.git";
          rev = "8fb2eb16bbba2cee1d115a6729659ac649da811b";
          sha256 = "04r9bmx9kc3jqx59hh9yqqkl95mf869la9as5h36jv85ynn464dx";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "lists" = pkgs.stdenv.mkDerivation {
        name = "lists";
        version = "v6.0.1";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript/purescript-lists.git";
          rev = "6383c4f202b3f69474f9f7da182c2d42fcc3111c";
          sha256 = "0xmg918s3mqvfvwgjfqcs1yvcz6hy2n7h3ygqz2iyvk868gz25qs";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "math" = pkgs.stdenv.mkDerivation {
        name = "math";
        version = "v3.0.0";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript/purescript-math.git";
          rev = "59746cc74e23fb1f04e09342884c5d1e3943a04f";
          sha256 = "0hkf0vyiga21992d9vbvdbnzdkvgljmsi497jjas1rk3vhblx8sq";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "maybe" = pkgs.stdenv.mkDerivation {
        name = "maybe";
        version = "v5.0.0";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript/purescript-maybe.git";
          rev = "8e96ca0187208e78e8df6a464c281850e5c9400c";
          sha256 = "0vyk3r9gklvv7awzpph7ra53zxxbin1ngmqflb5vvr2365v5xyqy";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "mmorph" = pkgs.stdenv.mkDerivation {
        name = "mmorph";
        version = "v6.0.0";
        src = pkgs.fetchgit {
          url = "https://github.com/Thimoteus/purescript-mmorph.git";
          rev = "ebe16afbfa16dd600f3379ccedc7529417402393";
          sha256 = "0ds88hray8v0519n9k546qsc4qs8bj1k5h5az7nwfp0gaq0r5wpk";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "newtype" = pkgs.stdenv.mkDerivation {
        name = "newtype";
        version = "v4.0.0";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript/purescript-newtype.git";
          rev = "7b292fcd2ac7c4a25d7a7a8d3387d0ee7de89b13";
          sha256 = "1fgzbxslckva2psn0sia30hfakx8xchz3wx2kkh3w8rr4nn2py8v";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "node-buffer" = pkgs.stdenv.mkDerivation {
        name = "node-buffer";
        version = "v7.0.1";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript-node/purescript-node-buffer.git";
          rev = "0721f1e8d768df48ae429547c8c60b121ca120cb";
          sha256 = "14bf3llsa20ivkwp5hlyk8v8zfzpzhhsni9pd8rfqdyzp6zrdx3b";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "node-fs" = pkgs.stdenv.mkDerivation {
        name = "node-fs";
        version = "v6.1.0";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript-node/purescript-node-fs.git";
          rev = "09a2b71a3a86f0cd19c46f4b6c40310cc1648909";
          sha256 = "1w97m2afn7yn757niknkbk7w6nyg4n5dabxr7gzfz368z1nkf45s";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "node-path" = pkgs.stdenv.mkDerivation {
        name = "node-path";
        version = "v4.0.0";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript-node/purescript-node-path.git";
          rev = "a2d7cf05e40b607ef7d048a3684cda788cd42890";
          sha256 = "1384qyf4v84wbahafzvqdxjllqy8qkd5dpkhsl3js444vsm2aplr";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "node-streams" = pkgs.stdenv.mkDerivation {
        name = "node-streams";
        version = "v5.0.0";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript-node/purescript-node-streams.git";
          rev = "886bb2045685e3b9031687d69ccfed29972147bb";
          sha256 = "1jc3d4x0v77h8qcwq7hpwprsdr3gqmdfiyr1ph0kiy7r9bbrqwfx";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "nonempty" = pkgs.stdenv.mkDerivation {
        name = "nonempty";
        version = "v6.1.0";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript/purescript-nonempty.git";
          rev = "7696eaf915da5333173bca7d779a51f91a525b83";
          sha256 = "0hhhw5x5xvs2bd9373gklja1545glnzi1xc2sj16kkznnayrmvsn";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "now" = pkgs.stdenv.mkDerivation {
        name = "now";
        version = "v5.0.0";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript-contrib/purescript-now.git";
          rev = "4c994dae8bb650787de1e4d9e709f2565fb354fb";
          sha256 = "1wa4j2h5rlw1lgfpm7rif3v6ksm8lplxl1x69zpk8hdf0cfyz4qm";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "nullable" = pkgs.stdenv.mkDerivation {
        name = "nullable";
        version = "v5.0.0";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript-contrib/purescript-nullable.git";
          rev = "8b19c16b16593102ae5d5d9f5b42eea0e213e2f5";
          sha256 = "0jbmks8kwhpb5fr2b9nb70fjwh6zdnwirycvzr77jafcny24yrnl";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "numbers" = pkgs.stdenv.mkDerivation {
        name = "numbers";
        version = "v8.0.0";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript/purescript-numbers.git";
          rev = "f5bbd96cbed58403c4445bd4c73df50fc8d86f46";
          sha256 = "00pm2x4kh4fm91r7nmik1v5jclkgh7gpxz13ambyqxbxbiqjq0vg";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "ordered-collections" = pkgs.stdenv.mkDerivation {
        name = "ordered-collections";
        version = "v2.0.2";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript/purescript-ordered-collections.git";
          rev = "1929b706b07e251995b6be51baa7995c61eb4d83";
          sha256 = "0g57043ylj3kldkm5vn233yd6hiamryhdfh72cxx9h3mn0ra8ghd";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "orders" = pkgs.stdenv.mkDerivation {
        name = "orders";
        version = "v5.0.0";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript/purescript-orders.git";
          rev = "c25b7075426cf82bcb960495f28d2541c9a75510";
          sha256 = "0wwy3ycjll0s590ra35zf5gjvs86w97rln09bj428axhg7cvfl0a";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "pairs" = pkgs.stdenv.mkDerivation {
        name = "pairs";
        version = "v8.0.0";
        src = pkgs.fetchgit {
          url = "https://github.com/sharkdp/purescript-pairs.git";
          rev = "97ae3cce9b0e00ff9473fff2779fcbcb4d7bc597";
          sha256 = "0qmkwgn08z4ff1rb4h8adk0fysn3qkgv2m3vgfbpcqff5sksdyqw";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "parallel" = pkgs.stdenv.mkDerivation {
        name = "parallel";
        version = "v5.0.0";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript/purescript-parallel.git";
          rev = "16b38a2e148639b04ae67e0ce63cc220da8857f7";
          sha256 = "0x8mvhgs8ygqj34xgyhk6gixqm32p2ymm00zg0zdw13g3lil9p4x";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "partial" = pkgs.stdenv.mkDerivation {
        name = "partial";
        version = "v3.0.0";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript/purescript-partial.git";
          rev = "2f0a5239efab68179a684603263bcec8f1489b08";
          sha256 = "0acxf686hvaj793hyb7kfn9lf96kv3nk0lls2p9j095ylp55sldb";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "pipes" = pkgs.stdenv.mkDerivation {
        name = "pipes";
        version = "v7.0.1";
        src = pkgs.fetchgit {
          url = "https://github.com/felixschl/purescript-pipes.git";
          rev = "42e43f0961ad0fc3f1cef6986fe23ca9f48f6dda";
          sha256 = "0jzgzi34wqqdcfgznbpfv4b8al2prd36yshnndlvkqfv70smx3kh";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "prelude" = pkgs.stdenv.mkDerivation {
        name = "prelude";
        version = "v5.0.1";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript/purescript-prelude.git";
          rev = "68f8012bc2309d9bf5832cdf7316ad052d586905";
          sha256 = "1x0cacvv9mmw80vy6f40y0p959q1dz28fwjswhyd7ws6npbklcy0";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "profunctor" = pkgs.stdenv.mkDerivation {
        name = "profunctor";
        version = "v5.0.0";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript/purescript-profunctor.git";
          rev = "4551b8e437a00268cc9b687cbe691d75e812e82b";
          sha256 = "0fvd2xiv77sp4jd4spgdp4i9812p6pdzzbg4pa96mbr0h19jf39c";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "profunctor-lenses" = pkgs.stdenv.mkDerivation {
        name = "profunctor-lenses";
        version = "v7.0.1";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript-contrib/purescript-profunctor-lenses.git";
          rev = "9c3d87a6dab8eb785a93bff11aa183796dc93183";
          sha256 = "1wknj7g6vwk2ga1rq57l470h322308ddjn5bd3x2hhfkiy039kc3";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "quickcheck" = pkgs.stdenv.mkDerivation {
        name = "quickcheck";
        version = "v7.1.0";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript/purescript-quickcheck.git";
          rev = "990fa1cf14b48b827d9b2d115b1c6977c4b0a76d";
          sha256 = "1dxchng3r2mad0505a0c7cc35vs1f7y2xb5i13p59jpdz6ijqa9k";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "random" = pkgs.stdenv.mkDerivation {
        name = "random";
        version = "v5.0.0";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript/purescript-random.git";
          rev = "3e02da113c7afbac37ea4e16188c39d3057314d5";
          sha256 = "1v6ykgp8jmx488hq8mgb0l0sf1nyhjs6wq0w279iyibk9jxc6nib";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "record" = pkgs.stdenv.mkDerivation {
        name = "record";
        version = "v3.0.0";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript/purescript-record.git";
          rev = "091495d61fcaa9d8d8232e7b800f403a3165a38f";
          sha256 = "0yidfvwiajiv8xflfsi2p8dqnp0qmmcz9jry58jyn9ga82z2pqn6";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "refs" = pkgs.stdenv.mkDerivation {
        name = "refs";
        version = "v5.0.0";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript/purescript-refs.git";
          rev = "f66d3cdf6a6bf4510e5181b3fac215054d8f1e2e";
          sha256 = "1jhc2v784jy8bvkqy4zsh2z7pnqrhwa8n5kx98xhxx73n1bf38sg";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "safe-coerce" = pkgs.stdenv.mkDerivation {
        name = "safe-coerce";
        version = "v1.0.0";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript/purescript-safe-coerce.git";
          rev = "e719defd227d932da067a1f0d62a60b3d3ff3637";
          sha256 = "0m942lc23317izspz1sxw957mwl9yb9bgk8dh23f7b3a8w9hh8ff";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "spec" = pkgs.stdenv.mkDerivation {
        name = "spec";
        version = "v5.0.1";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript-spec/purescript-spec.git";
          rev = "2cfa11573dbb695c117efce0a8f76a3daba12e87";
          sha256 = "0hpca1sa738029ww74zpw31br5x339q35kzb10iqd55lp6611k80";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "spec-discovery" = pkgs.stdenv.mkDerivation {
        name = "spec-discovery";
        version = "v6.0.0";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript-spec/purescript-spec-discovery.git";
          rev = "d62f3625861efc9cd61f5fba55c1fdc38b276684";
          sha256 = "11048rrxgr7bgcbrpna6k3zak1h40i2b2arjam7aypbz15ik1v4s";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "st" = pkgs.stdenv.mkDerivation {
        name = "st";
        version = "v5.0.1";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript/purescript-st.git";
          rev = "994eb5e650f3caedac385dcc61694f691df57983";
          sha256 = "14hz254f1y0k3v83z719np0ddrgbca0hdsd9dvv244i07vlvm2zj";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "strings" = pkgs.stdenv.mkDerivation {
        name = "strings";
        version = "v5.0.0";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript/purescript-strings.git";
          rev = "157e372a23e4becd594d7e7bff6f372a6f63dd82";
          sha256 = "0hyaa4d8gyyvac2nxnwqkn2rvi5vax4bi4yv10mpk7rgb8rv7mb8";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "tailrec" = pkgs.stdenv.mkDerivation {
        name = "tailrec";
        version = "v5.0.1";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript/purescript-tailrec.git";
          rev = "5fbf0ac05dc6ab1a228b2897630195eb7483b962";
          sha256 = "1jjl2q2hyhjcdxpamzr1cdlxhmq2bl170x5p3jajb9zgwkqx0x22";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "transformers" = pkgs.stdenv.mkDerivation {
        name = "transformers";
        version = "v5.2.0";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript/purescript-transformers.git";
          rev = "1e5d4193b38c613c97ea1ebdb721c6b94cd8c50a";
          sha256 = "0lggimnq016v98ib6h68gnciraambxrfqm2s033wm34srcy8xs06";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "tuples" = pkgs.stdenv.mkDerivation {
        name = "tuples";
        version = "v6.0.1";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript/purescript-tuples.git";
          rev = "d4fe8ffe9e8c512111ee0bc18a6ba0fd056a6773";
          sha256 = "0s2ar2gih4r34km8r8dqngh21s8899yb93mb7mips08ndy3ajq3a";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "type-equality" = pkgs.stdenv.mkDerivation {
        name = "type-equality";
        version = "v4.0.0";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript/purescript-type-equality.git";
          rev = "f7644468f22ed267a15d398173d234fa6f45e2e0";
          sha256 = "126pg4zg3bsrn8dzvv75xp586nznxyswzgjlr7cag3ij3j1z0kl0";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "typelevel-prelude" = pkgs.stdenv.mkDerivation {
        name = "typelevel-prelude";
        version = "v6.0.0";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript/purescript-typelevel-prelude.git";
          rev = "83ddcdb23d06c8d5ea6196596a70438f42cd4afd";
          sha256 = "1vwf3yhn8mir5y41wvlyszkgd5fxvrcyfd0l8cn20c8vfq36yzgk";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "undefined" = pkgs.stdenv.mkDerivation {
        name = "undefined";
        version = "v1.0.2";
        src = pkgs.fetchgit {
          url = "https://github.com/bklaric/purescript-undefined.git";
          rev = "4012dc06b58feae301140bc081135d0f24c432b0";
          sha256 = "0kj504j3r9wr7m3yhm53bcfdzai0c2g99d2pdxlfinxk4pmixyrd";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "unfoldable" = pkgs.stdenv.mkDerivation {
        name = "unfoldable";
        version = "v5.0.0";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript/purescript-unfoldable.git";
          rev = "bbcc2b062b9b7d3d61f123cfb32cc8c7fb811aa6";
          sha256 = "1v3bz04wj6hj7s6mcf49hajylg6w58n78q54sqi2ra2zq8h99kpw";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "unsafe-coerce" = pkgs.stdenv.mkDerivation {
        name = "unsafe-coerce";
        version = "v5.0.0";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript/purescript-unsafe-coerce.git";
          rev = "ee24f0d3b94bf925d9c50fcc2b449579580178c0";
          sha256 = "0l2agnm1k910v4yp1hz19wrsrywsr5scb397762y7pigm3frzs8r";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "variant" = pkgs.stdenv.mkDerivation {
        name = "variant";
        version = "v7.0.3";
        src = pkgs.fetchgit {
          url = "https://github.com/natefaubion/purescript-variant.git";
          rev = "3f12411ede5edd342d25340c1babce9ae81d6793";
          sha256 = "1q2pky3gf177ihy2zjzqvp1cj18ycaki9vm4ghw18p7hf256lqmc";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

  };

  cpPackage = pkg:
    let
      target = ".spago/${pkg.name}/${pkg.version}";
    in ''
      if [ ! -e ${target} ]; then
        echo "Installing ${target}."
        mkdir -p ${target}
        cp --no-preserve=mode,ownership,timestamp -r ${toString pkg.outPath}/* ${target}
      else
        echo "${target} already exists. Skipping."
      fi
    '';

  getGlob = pkg: ''".spago/${pkg.name}/${pkg.version}/src/**/*.purs"'';

  getStoreGlob = pkg: ''"${pkg.outPath}/src/**/*.purs"'';

in {
  inherit inputs;

  installSpagoStyle = pkgs.writeShellScriptBin "install-spago-style" ''
      set -e
      echo installing dependencies...
      ${builtins.toString (builtins.map cpPackage (builtins.attrValues inputs))}
      echo "echo done."
  '';

  buildSpagoStyle = pkgs.writeShellScriptBin "build-spago-style" ''
      set -e
      echo building project...
      purs compile ${builtins.toString (builtins.map getGlob (builtins.attrValues inputs))} "$@"
      echo done.
  '';

  buildFromNixStore = pkgs.writeShellScriptBin "build-from-store" ''
      set -e
      echo building project using sources from nix store...
      purs compile ${builtins.toString (
        builtins.map getStoreGlob (builtins.attrValues inputs))} "$@"
      echo done.
  '';

  mkBuildProjectOutput =
    { src, purs }:

    pkgs.stdenv.mkDerivation {
      name = "build-project-output";
      src = src;

      buildInputs = [ purs ];

      installPhase = ''
        mkdir -p $out
        purs compile "$src/**/*.purs" ${builtins.toString
          (builtins.map
            (x: ''"${x.outPath}/src/**/*.purs"'')
            (builtins.attrValues inputs))}
        mv output $out
      '';
    };
}
