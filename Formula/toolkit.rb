class Toolkit < Formula
  desc "Shared engineering toolkit — principles, scripts, and Codex pre-push review for all projects"
  homepage "https://github.com/henrymodisett/toolkit"
  url "https://github.com/henrymodisett/toolkit/archive/refs/tags/v0.7.7.tar.gz"
  sha256 "23bf96551e8dd3def35dbcf7a9561c64b75c16f2f91f92a29146285c8872cd00"
  license "MIT"

  depends_on "gh"
  depends_on "git"

  def install
    # Install everything under libexec, symlink the CLI into bin.
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/toolkit"

    # Shell completions.
    zsh_completion.install libexec/"completions/toolkit.zsh" => "_toolkit"
    bash_completion.install libexec/"completions/toolkit.bash" => "toolkit"
  end

  def caveats
    <<~'EOS'
      toolkit
       _____  _  __
      |_   _|| |/ /
        | |  | ' /
        |_|  |_|\_\

      Start in a repo:
        toolkit init
        toolkit status
        toolkit help
    EOS
  end

  test do
    assert_match "toolkit v", shell_output("#{bin}/toolkit version")
  end
end
