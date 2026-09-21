# Homebrew Formula for Vokt
# To install: brew install voktlabs/vokt/vokt

class Vokt < Formula
  desc "Language-agnostic call graph extraction via tree-sitter and Soufflé"
  homepage "https://github.com/voktlabs/homebrew-vokt"
  version "2.0.63"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/voktlabs/homebrew-vokt/releases/download/v2.0.63/vokt-darwin-arm64"
      sha256 "acd8846c5b45b0c8477d263f9081b03e98ae28775fe8d95e2c16576adc11ceb5"
    else
      url "https://github.com/voktlabs/homebrew-vokt/releases/download/v2.0.63/vokt-darwin-amd64"
      sha256 "6270ae1e4a25ab071869e0f8bc5d809460e1b47f0de74512ce5d831a8346ede6"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/voktlabs/homebrew-vokt/releases/download/v2.0.63/vokt-linux-arm64"
      sha256 "20b497a8d872bb07fc74b1170ce5f1fd8fd4be79ec07af5dbbf9bff83ad4a15c"
    else
      url "https://github.com/voktlabs/homebrew-vokt/releases/download/v2.0.63/vokt-linux-amd64"
      sha256 "34f3c97913d725c3f144ed1e4175446becaab5e2189700ad6879da24fc06f291"
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
