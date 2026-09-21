# Homebrew Formula for Vokt
# To install: brew install voktlabs/vokt/vokt

class Vokt < Formula
  desc "Language-agnostic call graph extraction via tree-sitter and Soufflé"
  homepage "https://github.com/voktlabs/homebrew-vokt"
  version "2.0.66"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/voktlabs/homebrew-vokt/releases/download/v2.0.66/vokt-darwin-arm64"
      sha256 "0409aeeaa1c61514ed062850e5b23db6342866ba7f63b63d34112ab86efd5982"
    else
      url "https://github.com/voktlabs/homebrew-vokt/releases/download/v2.0.66/vokt-darwin-amd64"
      sha256 "577579a75c4005a6c6c918407dc7868476bbabf990a624e9708a2c14e9a0f7e3"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/voktlabs/homebrew-vokt/releases/download/v2.0.66/vokt-linux-arm64"
      sha256 "7c9030b1a892127a671530d0a1e1990312e8d79aaa1a779065e1523d18be9653"
    else
      url "https://github.com/voktlabs/homebrew-vokt/releases/download/v2.0.66/vokt-linux-amd64"
      sha256 "c85cf6d9faab1ad11361f9408f72901903b48ea80a5de3c34afa1fbcc3c8625f"
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
