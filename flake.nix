{
  description = "A collection of flake templates";

  outputs = { self }: {
    templates = {
      scala-js = {
        path = ./scala-js;
        description = "ScalaJS support with sbt, node, and yarn";
      };
      haskell-exe = {
        path = ./haskell-executable;
        description = "Haskell template for simple haskell exe";
      };
      python-ds-stack = {
        path = ./python-ds-stack;
        description = "Python dev environment with pandas and visualization tools";
      };
    };
  };
}
