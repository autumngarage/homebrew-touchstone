class Touchstone < Formula
  desc "Shared engineering starter kit with deterministic checks and PR review"
  homepage "https://github.com/autumngarage/touchstone"
  url "https://github.com/autumngarage/touchstone/archive/refs/tags/v2.12.0.tar.gz"
  sha256 "9fa68597d9413bf816d6dbd8ec411b3fc83eaa21c0f1b5772fa6e22a585b2725"
  license "MIT"

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
