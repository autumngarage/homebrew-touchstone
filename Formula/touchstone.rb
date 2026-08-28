class Touchstone < Formula
  desc "Delivery baseline for agent-driven repositories: adopt, validate, steer, ship"
  homepage "https://github.com/autumngarage/touchstone"
  url "https://github.com/autumngarage/touchstone/archive/refs/tags/v3.7.6.tar.gz"
  sha256 "f3b7dbdc9a796346dff1d9494dcd43031109b7268f9fdb094e94cc98d4ba940c"
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

      brew upgrade updates this tool only; it never modifies a repository.
    EOS
  end

  test do
    assert_match "touchstone v#{version}", shell_output("#{bin}/touchstone version")
  end
end
