{
  description = ''Pure Nim driver for MongoDB with support of synchronous and asynchronous I/O modes'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-nimongo-v0_2_0.flake = false;
  inputs.src-nimongo-v0_2_0.owner = "SSPkrolik";
  inputs.src-nimongo-v0_2_0.ref   = "v0_2_0";
  inputs.src-nimongo-v0_2_0.repo  = "nimongo";
  inputs.src-nimongo-v0_2_0.type  = "github";
  
  inputs."scram".owner = "nim-nix-pkgs";
  inputs."scram".ref   = "master";
  inputs."scram".repo  = "scram";
  inputs."scram".dir   = "0_1_13";
  inputs."scram".type  = "github";
  inputs."scram".inputs.nixpkgs.follows = "nixpkgs";
  inputs."scram".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-nimongo-v0_2_0"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-nimongo-v0_2_0";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}