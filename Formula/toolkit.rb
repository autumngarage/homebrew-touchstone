class Toolkit < Formula
  desc "Shared engineering toolkit — principles, scripts, and Codex pre-push review for all projects"
  homepage "https://github.com/henrymodisett/toolkit"
  url "https://github.com/henrymodisett/toolkit/archive/refs/tags/v0.7.1.tar.gz"
  sha256 "8623563641c6a29723931b3ea7460b0551983c53f1b9c76e87b97af1b869ebca"
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
