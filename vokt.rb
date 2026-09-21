# Homebrew Formula for Vokt
# To install: brew install voktlabs/vokt/vokt

class Vokt < Formula
  desc "Language-agnostic call graph extraction via tree-sitter and Soufflé"
  homepage "https://github.com/voktlabs/homebrew-vokt"
  version "2.0.64"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/voktlabs/homebrew-vokt/releases/download/v2.0.64/vokt-darwin-arm64"
      sha256 "367cee98d167cfb60674e1dc0e7c1f3a43c662714d1d89d0999743f7458540d5"
    else
      url "https://github.com/voktlabs/homebrew-vokt/releases/download/v2.0.64/vokt-darwin-amd64"
      sha256 "6ad118224a7e10e794c60d8a2e1a16fae9554aab93a045bea3c882ed2c7e94ff"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/voktlabs/homebrew-vokt/releases/download/v2.0.64/vokt-linux-arm64"
      sha256 "99346f764e8162f5de545416d859af55f9ffa0205d7f17ff5dbe9292554742f9"
    else
      url "https://github.com/voktlabs/homebrew-vokt/releases/download/v2.0.64/vokt-linux-amd64"
      sha256 "c76dc90f1cf6fe286d5b2ceffdff7e94cf184798aa56677162dd5a5b2158a46a"
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
