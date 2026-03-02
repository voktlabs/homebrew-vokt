# Homebrew Formula for Vokt
# To install: brew install maneeshchaturvedi/vokt/vokt

class Vokt < Formula
  desc "AI-powered specification-driven development for legacy code"
  homepage "https://github.com/maneeshchaturvedi/homebrew-vokt"
  version "2.0.25"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/maneeshchaturvedi/homebrew-vokt/releases/download/v2.0.25/vokt-darwin-arm64"
      sha256 "ebdef3c16e40504fdfb10f982a339a90ae4dbc70e83fe9a8e9007747aaeba891"
    else
      url "https://github.com/maneeshchaturvedi/homebrew-vokt/releases/download/v2.0.25/vokt-darwin-amd64"
      sha256 "388538871d1b59ba64498abe70abf327102d0d8b67e5fbc90fd436acb79a482a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/maneeshchaturvedi/homebrew-vokt/releases/download/v2.0.25/vokt-linux-arm64"
      sha256 "3d0add3d4a6d3f56943b0343b321be0bf9b9173737cf5c4a7bf9192db6f2e35f"
    else
      url "https://github.com/maneeshchaturvedi/homebrew-vokt/releases/download/v2.0.25/vokt-linux-amd64"
      sha256 "4c4ad21cc667d298bb09fbcb4e3fa798f8eaee4b14faac66feaa1f8a3c90bba0"
    end
  end

  def install
    bin.install "vokt-darwin-arm64" => "vokt" if Hardware::CPU.arm? && OS.mac?
    bin.install "vokt-darwin-amd64" => "vokt" if Hardware::CPU.intel? && OS.mac?
    bin.install "vokt-linux-arm64" => "vokt" if Hardware::CPU.arm? && OS.linux?
    bin.install "vokt-linux-amd64" => "vokt" if Hardware::CPU.intel? && OS.linux?
  end

  test do
    assert_match "Vokt", shell_output("#{bin}/vokt --version")
  end
end
