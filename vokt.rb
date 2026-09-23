# Homebrew Formula for Vokt
# To install: brew install voktlabs/vokt/vokt

class Vokt < Formula
  desc "Language-agnostic call graph extraction via tree-sitter and Soufflé"
  homepage "https://github.com/voktlabs/homebrew-vokt"
  version "2.0.67"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/voktlabs/homebrew-vokt/releases/download/v2.0.67/vokt-darwin-arm64"
      sha256 "1457c32d0eab7a82b35b876176350cc858d537049d1a9d3f05f1c759c21131cd"
    else
      url "https://github.com/voktlabs/homebrew-vokt/releases/download/v2.0.67/vokt-darwin-amd64"
      sha256 "f6a0c0f6b34a548b6d84b389e4f84a322c62ddd62dbcb034c45bd8bf21b85bce"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/voktlabs/homebrew-vokt/releases/download/v2.0.67/vokt-linux-arm64"
      sha256 "ec748c312a7e804ed946d0a310f1e5ec0ea655d4f10f8209cea725b43fad2846"
    else
      url "https://github.com/voktlabs/homebrew-vokt/releases/download/v2.0.67/vokt-linux-amd64"
      sha256 "caea265647aa2daaba9b0c887b8461457411aea9ecf4523a20161ddab038abf3"
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
