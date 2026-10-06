# Homebrew Formula for Vokt
# To install: brew install voktlabs/vokt/vokt

class Vokt < Formula
  desc "Language-agnostic call graph extraction via tree-sitter and Soufflé"
  homepage "https://github.com/voktlabs/homebrew-vokt"
  version "2.0.68"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/voktlabs/homebrew-vokt/releases/download/v2.0.68/vokt-darwin-arm64"
      sha256 "a704c653f230709f23c95938df61b82d04dd007f23b89ae8f407d95b7e4f94f8"
    else
      url "https://github.com/voktlabs/homebrew-vokt/releases/download/v2.0.68/vokt-darwin-amd64"
      sha256 "2cd9b573674c357d94be79f7259babe8aa0f49d68ad7292d7aaa9ab29594345b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/voktlabs/homebrew-vokt/releases/download/v2.0.68/vokt-linux-arm64"
      sha256 "79ccd48586ba93103e92e7a284b140eb90b677241d3dd5ef7d941985e44a0355"
    else
      url "https://github.com/voktlabs/homebrew-vokt/releases/download/v2.0.68/vokt-linux-amd64"
      sha256 "c22a01fca60f4c41b1b5713943950a14fccee78480d634cba4a0d5b7f9700e51"
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
