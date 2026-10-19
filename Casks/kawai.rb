cask "kawai" do
  version :latest
  sha256 :no_check

  url "https://github.com/yudaprama/kawai/releases/latest/download/kawai_aarch64.dmg"
  name "kawai"
  desc "Supervisor-driven AI workspace"
  homepage "https://github.com/yudaprama/kawai"

  # The app ships its own minisign-verified auto-updater; the cask only
  # installs once and never nags. The stable permalink is produced by
  # releaseAssetNamePattern in the release workflow.
  livecheck do
    skip "self-updates in app; cask tracks :latest"
  end

  auto_updates true
  depends_on arch: :arm64

  app "kawai.app"

  preflight_steps do
    # Clear quarantine flag for existing app before upgrading
    quarantine_file = "/Applications/kawai.app"
    if File.exist?(quarantine_file)
      SystemCommand.run("xattr", args: ["-dr", "com.apple.quarantine", quarantine_file])
    end
  end
end
