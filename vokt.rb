# Homebrew Formula for Vokt
# To install: brew install maneeshchaturvedi/vokt/vokt

class Vokt < Formula
  desc "AI-powered specification-driven development for legacy code"
  homepage "https://github.com/maneeshchaturvedi/homebrew-vokt"
  version "2.0.27"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/maneeshchaturvedi/homebrew-vokt/releases/download/v2.0.27/vokt-darwin-arm64"
      sha256 "1ef1a1a7affdc6754d30cb771b5cf97e4d6c42b0a50521bb7322908517c48f6c"
    else
      url "https://github.com/maneeshchaturvedi/homebrew-vokt/releases/download/v2.0.27/vokt-darwin-amd64"
      sha256 "96d147bb02f3505365cfab6bc5d228f7f119ee1fcf05c4c418874da6b8e4ab8c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/maneeshchaturvedi/homebrew-vokt/releases/download/v2.0.27/vokt-linux-arm64"
      sha256 "a155a04f0ffe6c31eaae3ddd57cee4ce42a9b3c3dc49b9e1a8c30989d075d3a2"
    else
      url "https://github.com/maneeshchaturvedi/homebrew-vokt/releases/download/v2.0.27/vokt-linux-amd64"
      sha256 "2df765369401b8b7f5a4dedce0292c85b6cfe0e5165dd26c9a2602d9cb42df5c"
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
