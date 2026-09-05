class Touchstone < Formula
  desc "Delivery baseline for agent-driven repositories: adopt, validate, steer, ship"
  homepage "https://github.com/autumngarage/touchstone"
  url "https://github.com/autumngarage/touchstone/archive/refs/tags/v3.11.0.tar.gz"
  sha256 "b1527e6ae43621d7ae11540bf64f86d82391a9f5d405347abf31752335739db7"
  license "MIT"

  depends_on "gh"
  depends_on "git"
  depends_on "jq"

  def install
    # The CLI resolves its root through the symlink, so the whole tree lives
    # under libexec: bin/, scripts/, principles/, TOUCHSTONE.md, VERSION,
    # and the policy catalog. Nothing here touches any repository.
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/touchstone"
  end

  def caveats
    <<~EOS
      Install the shared agent steering once per machine (idempotent):
        touchstone steering install

      Adopt a repository (writes its declarations only; review the plan first):
        touchstone adopt --dry-run
        touchstone adopt

      Open, inspect, and merge pull requests through the bounded boundary:
        touchstone pr open --title ... --body-file ... --expect-branch <branch>
        touchstone pr status <n>
        touchstone pr merge <n> --head <sha>

      To upgrade later, prefer:
        touchstone upgrade

      It runs brew upgrade and then reinstalls the machine steering, so the
      contract your agents read matches the CLI. A bare `brew upgrade` refreshes
      only this tool: the steering already installed under ~/.claude, ~/.codex
      and ~/.gemini keeps whatever contract it was installed with, silently, and
      your agents keep reading it. `touchstone steering check` reports the skew;
      `touchstone steering install` repairs it.

      Neither command ever modifies a repository.
    EOS
  end

  test do
    assert_match "touchstone v#{version}", shell_output("#{bin}/touchstone version")
  end
end
