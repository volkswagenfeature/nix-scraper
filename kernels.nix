{pkgs, ...}: {
  kernel.python.minimal = {
    enable = true;
  };
  kernel.python.webscraper = {
    enable = true;
    extraPackages = ps: (with ps; [
      requests
      beautifulsoup4
      flask
      pandas
      numpy
      huey
    ]);
  };
}
