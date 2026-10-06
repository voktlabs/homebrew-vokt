# Homebrew Formula for Vokt
# To install: brew install voktlabs/vokt/vokt

class Vokt < Formula
  desc "Language-agnostic call graph extraction via tree-sitter and Soufflé"
  homepage "https://github.com/voktlabs/homebrew-vokt"
  version "2.0.70"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/voktlabs/homebrew-vokt/releases/download/v2.0.70/vokt-darwin-arm64"
      sha256 "2e34f78a0fcc2134fb3f3618846e749a0850c485e12bdc7950660bb5d9fd699e"
    else
      url "https://github.com/voktlabs/homebrew-vokt/releases/download/v2.0.70/vokt-darwin-amd64"
      sha256 "c8143663d50f8990847e8850db617418418bc8ae8766c92863531954089f049e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/voktlabs/homebrew-vokt/releases/download/v2.0.70/vokt-linux-arm64"
      sha256 "189fe405243fd199c73133d47f852859c27b2db34b990d9227e0e13cc484f61c"
    else
      url "https://github.com/voktlabs/homebrew-vokt/releases/download/v2.0.70/vokt-linux-amd64"
      sha256 "faeb57b999bef67a132503b3c2f28304401decb82259d260d7f7eb7ec024d625"
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
