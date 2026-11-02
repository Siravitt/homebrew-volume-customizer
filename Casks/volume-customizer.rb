cask "volume-customizer" do
  version "0.1.0"
  sha256 "0e80e9980d25147d16780c4ffad5824a6ca0cf181d2b9438421d8b52f73dcec4"

  url "https://github.com/Siravitt/Volume-Customizer/releases/download/v#{version}/VolumeCustomizer-#{version}.zip"
  name "Volume Customizer"
  desc "Per-app volume control from the menu bar"
  homepage "https://github.com/Siravitt/Volume-Customizer"

  depends_on macos: :sonoma

  app "VolumeCustomizer.app"

  # Volume Customizer is signed with a self-signed certificate, not an Apple Developer ID,
  # so Gatekeeper would refuse to open it. Removing the quarantine flag lets it launch.
  postflight_steps do
    run "/usr/bin/xattr",
        args: ["-dr", "com.apple.quarantine", "{{appdir}}/VolumeCustomizer.app"]
  end

  uninstall quit: "dev.volumecustomizer.VolumeCustomizer"

  zap trash: "~/Library/Preferences/dev.volumecustomizer.VolumeCustomizer.plist"

  caveats <<~EOS
    Volume Customizer is not notarized by Apple. This cask removes the quarantine
    flag so macOS will open it. Source: https://github.com/Siravitt/Volume-Customizer

    Requires macOS 14.2 or later.
  EOS
end
