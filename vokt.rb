# Homebrew Formula for Vokt
# To install: brew install voktlabs/vokt/vokt

class Vokt < Formula
  desc "Language-agnostic call graph extraction via tree-sitter and Soufflé"
  homepage "https://github.com/voktlabs/homebrew-vokt"
  version "2.0.71"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/voktlabs/homebrew-vokt/releases/download/v2.0.71/vokt-darwin-arm64"
      sha256 "cb3aa10a8ab0179c44fb2f13d20726f428cf9b1bfab2962a070583f24d0871dc"
    else
      url "https://github.com/voktlabs/homebrew-vokt/releases/download/v2.0.71/vokt-darwin-amd64"
      sha256 "93a91bbc3e1a5744edb4ceb956568f4e7d7e59b80165a5bcadb5b9d2ad8bae9d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/voktlabs/homebrew-vokt/releases/download/v2.0.71/vokt-linux-arm64"
      sha256 "32b54823097c602df0d69ffb9f3160497ce70ee0dc94b301d11419a827aa1b98"
    else
      url "https://github.com/voktlabs/homebrew-vokt/releases/download/v2.0.71/vokt-linux-amd64"
      sha256 "051ec3e27dc718a1859fe290feeb7ae2baa0faa0f967ee710bfdaf820b1a5cf3"
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
