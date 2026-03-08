# Homebrew Formula for Vokt
# To install: brew install maneeshchaturvedi/vokt/vokt

class Vokt < Formula
  desc "AI-powered specification-driven development for legacy code"
  homepage "https://github.com/maneeshchaturvedi/homebrew-vokt"
  version "2.0.31"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/maneeshchaturvedi/homebrew-vokt/releases/download/v2.0.31/vokt-darwin-arm64"
      sha256 "608836aaf7f8407ef70b589e4a5bbd7353aa08ddc8249305919ef9b8e5bc2ca9"
    else
      url "https://github.com/maneeshchaturvedi/homebrew-vokt/releases/download/v2.0.31/vokt-darwin-amd64"
      sha256 "5756da0a4de3291591c01665ba4b76c6f8f5fdc69ad4b2f7ab548252dac8e215"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/maneeshchaturvedi/homebrew-vokt/releases/download/v2.0.31/vokt-linux-arm64"
      sha256 "18cd6345f0e5c859ddb7a72ffd408829ab0eac423508af22b46d97710e6f2bec"
    else
      url "https://github.com/maneeshchaturvedi/homebrew-vokt/releases/download/v2.0.31/vokt-linux-amd64"
      sha256 "d326c1facb4827800902ecb6ff89673a66d0ec7365ebdd6955fd25cb20a6291f"
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
