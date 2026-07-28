class Touchstone < Formula
  desc "Shared engineering starter kit — principles, scripts, and Codex pre-push review for all projects"
  homepage "https://github.com/autumngarage/touchstone"
  url "https://github.com/autumngarage/touchstone/archive/refs/tags/v2.11.47.tar.gz"
  sha256 "f6697f4bb1a5fc6d38f33b6bc1c268088e08d58640234bce26250aa109862895"
  license "MIT"

  depends_on "autumngarage/conductor/conductor"
  depends_on "gh"
  depends_on "git"

  def install
    # Install everything under libexec, symlink the CLI into bin.
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/touchstone"

    # Shell completions.
    zsh_completion.install libexec/"completions/touchstone.zsh" => "_touchstone"
    bash_completion.install libexec/"completions/touchstone.bash" => "touchstone"
  end

  def caveats
    <<~'EOS'
      touchstone
       _               _       _
      | |_ ___ _  _ __| |_  __| |_ ___ _ _  ___
      |  _/ _ \\ || / _| ' \\(_-<  _/ _ \\ ' \\/ -_)
       \\__\\___/\\_,_\\__|_||_/__/\\__\\___/_||_\\___|

      Start in a repo:
        touchstone init
        touchstone status
        touchstone help
    EOS
  end

  test do
    assert_match "touchstone v", shell_output("#{bin}/touchstone version")
  end
end
