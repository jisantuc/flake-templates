{
  description = "A collection of flake templates";

  outputs = { self }: {
    templates = {
      scala-js = {
        path = ./scala-js;
        description = "ScalaJS support with sbt, node, and yarn";
      };
    };
  };
}
