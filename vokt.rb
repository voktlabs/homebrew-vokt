# Homebrew Formula for Vokt
# To install: brew install voktlabs/vokt/vokt

class Vokt < Formula
  desc "Language-agnostic call graph extraction via tree-sitter and Soufflé"
  homepage "https://github.com/voktlabs/homebrew-vokt"
  version "2.0.65"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/voktlabs/homebrew-vokt/releases/download/v2.0.65/vokt-darwin-arm64"
      sha256 "363b71662d807397066bc87aee04f65fef67c06c9d72c93383b01b2655c4f739"
    else
      url "https://github.com/voktlabs/homebrew-vokt/releases/download/v2.0.65/vokt-darwin-amd64"
      sha256 "79b4f996c8326b0eb932d012c5e71dd9a5747676ef24ff655dbf060e227c3c8c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/voktlabs/homebrew-vokt/releases/download/v2.0.65/vokt-linux-arm64"
      sha256 "1e2c2c8de4cc02f48bd695749f083a9864b9b5d6bdb10cc23ff2afcebc930510"
    else
      url "https://github.com/voktlabs/homebrew-vokt/releases/download/v2.0.65/vokt-linux-amd64"
      sha256 "06270e460aee0b2ec0a7498665fe661f7ab5151feab716df12d1cdfbf85228b9"
    end
  end

  def install
    bin.install "vokt-darwin-arm64" => "vokt" if Hardware::CPU.arm? && OS.mac?
    bin.install "vokt-darwin-amd64" => "vokt" if Hardware::CPU.intel? && OS.mac?
    bin.install "vokt-linux-arm64" => "vokt" if Hardware::CPU.arm? && OS.linux?
    bin.install "vokt-linux-amd64" => "vokt" if Hardware::CPU.intel? && OS.linux?
  end

  test do
    assert_match "vokt", shell_output("#{bin}/vokt --version")
  end
end
