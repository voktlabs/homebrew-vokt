# Homebrew Formula for Vokt
# To install: brew install voktlabs/vokt/vokt

class Vokt < Formula
  desc "Language-agnostic call graph extraction via tree-sitter and Soufflé"
  homepage "https://github.com/voktlabs/homebrew-vokt"
  version "2.0.62"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/voktlabs/homebrew-vokt/releases/download/v2.0.62/vokt-darwin-arm64"
      sha256 "54a9e23fcd4be6b2ee936ed700f9db1b137704d1db39c30483a2d650d86e8663"
    else
      url "https://github.com/voktlabs/homebrew-vokt/releases/download/v2.0.62/vokt-darwin-amd64"
      sha256 "0b3b5ca606625b37fe6815e9941ba8a242c935b35c14cba4f1c8c251c10ba6fb"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/voktlabs/homebrew-vokt/releases/download/v2.0.62/vokt-linux-arm64"
      sha256 "277b6e2fe08c9f4c805c606d28555bf4f21d0bc03952cb66e6680aef8943a6dc"
    else
      url "https://github.com/voktlabs/homebrew-vokt/releases/download/v2.0.62/vokt-linux-amd64"
      sha256 "3eb6acb253451ea081241f64a80f046013972bfd23e2a5d5b04a56a1e3be50d3"
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
