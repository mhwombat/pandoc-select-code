# pandoc-select-code

Pandoc filter to extract only the code blocks.
You might use this, for example, to extract sample code from a tutorial.

I originally developed this filter because I wanted something like literate Haskell,
but using Markdown.
I wanted to be able to write a Markdown file with Haskell code blocks,
and then be able to compile and execute it, or use Pandoc to produce a PDF.
Cabal doesn't support that, so one workaround is to pre-process the file
using Pandoc with this filter and the `--write=plain` option to produce a source file that can be compiled.

I also use this when I'm updating a tutorial I wrote some time ago;
I'll extract the code examples and verify that they still work with the latest software.

## Installation

This package is available from Hackage, or as a Nix flake.

### From Hackage

To install from Hackage, use [cabal install](https://cabal.readthedocs.io/en/stable/cabal-commands.html#cabal-install).
The package name is `pandoc-select-code`.

### In a Nix shell

Note: Flakes must be [enabled](https://nixos.wiki/wiki/Flakes) in your Nix or NixOS installation.

One way to use the Nix flake is to create a `shell.nix` with pandoc and this package, like so:

~~~
with (import <nixpkgs> {});
let
  pandoc-include-plus = (builtins.getFlake git+https://codeberg.org/mhwombat/pandoc-include-plus).packages.${builtins.currentSystem}.default;
in
mkShell {
  buildInputs = [
    pandoc
    pandoc-select-code
    # add any other software you want to use in the shell.
  ];
}
~~~

Enter the shell using `nix-shell`, and this package will be available for use.

### In a Nix flake

Add this package to your `flake.nix`:

```nix
{
  inputs.pandoc-select-code.url = "github:mhwombat/pandoc-select-code";

  outputs = { self, pandoc-select-code }: {
    # Use in your outputs
  };
}

```

## Transforming to other formats

You can process your Markdown document either using pandoc directly,
or through Hakyll.

### With Pandoc

Use this filter by adding `--filter=pandoc-select-code` to your pandoc command.
For example:

    pandoc --filter=pandoc-linear-table myfile.md --output=myfile.pdf

### With Hakyll

Use this filter as a transform in Hakyll.
For example, you could modify `site.hs`, adding

```
import Text.Pandoc.Filters.SelectCode (transform)
```

and changing

```
pandocCompiler
```

to

```
pandocCompilerWithTransform defaultHakyllReaderOptions defaultHakyllWriterOptions transform
```

