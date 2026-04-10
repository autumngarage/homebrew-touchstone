class Toolkit < Formula
  desc "Shared engineering toolkit — principles, scripts, and Codex pre-push review for all projects"
  homepage "https://github.com/henrymodisett/toolkit"
  url "https://github.com/henrymodisett/toolkit/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "335f7bd24d7bb0999c948d21fa026cc2126ddde33d09eb16b44c2c444b9eb416"
  license "MIT"

  depends_on "gh"
  depends_on "git"

  def install
    # Install everything under libexec, symlink the CLI into bin.
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/toolkit"
  end

  test do
    assert_match "toolkit v", shell_output("#{bin}/toolkit version")
  end
end
