class Toolkit < Formula
  desc "Shared engineering toolkit — principles, scripts, and Codex pre-push review for all projects"
  homepage "https://github.com/henrymodisett/toolkit"
  url "https://github.com/henrymodisett/toolkit/archive/refs/tags/v0.7.4.tar.gz"
  sha256 "a3f91119a3fed5516ebc3463188d21d745bec820ac1d4c8f975027a797726832"
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
