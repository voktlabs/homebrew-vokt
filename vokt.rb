# Homebrew Formula for Vokt
# To install: brew install maneeshchaturvedi/vokt/vokt

class Vokt < Formula
  desc "AI-powered specification-driven development for legacy code"
  homepage "https://github.com/maneeshchaturvedi/homebrew-vokt"
  version "2.0.28"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/maneeshchaturvedi/homebrew-vokt/releases/download/v2.0.28/vokt-darwin-arm64"
      sha256 "d398e8ef74e3dbea4fc8698125136fadfb6f29078541b96a15e3163a31af7525"
    else
      url "https://github.com/maneeshchaturvedi/homebrew-vokt/releases/download/v2.0.28/vokt-darwin-amd64"
      sha256 "17e00455c99ccf28f8d90e449026d1c04df8556da94b9c47a596747be47ccfa1"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/maneeshchaturvedi/homebrew-vokt/releases/download/v2.0.28/vokt-linux-arm64"
      sha256 "04245baefd7083773f33398213e28a4bfcb1937d7a3bc84aafd342dda96152eb"
    else
      url "https://github.com/maneeshchaturvedi/homebrew-vokt/releases/download/v2.0.28/vokt-linux-amd64"
      sha256 "89f55db94810ab6722466ddee11abbeab7577d4be6a7708f2542663a2b879ec7"
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
