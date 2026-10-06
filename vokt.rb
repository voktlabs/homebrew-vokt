# Homebrew Formula for Vokt
# To install: brew install voktlabs/vokt/vokt

class Vokt < Formula
  desc "Language-agnostic call graph extraction via tree-sitter and Soufflé"
  homepage "https://github.com/voktlabs/homebrew-vokt"
  version "2.0.69"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/voktlabs/homebrew-vokt/releases/download/v2.0.69/vokt-darwin-arm64"
      sha256 "6e10ac9ce31097d1b9350a655346df78f0f5a544482bb4dd53139beca5d07da9"
    else
      url "https://github.com/voktlabs/homebrew-vokt/releases/download/v2.0.69/vokt-darwin-amd64"
      sha256 "76b40573eb07151f86b08fe284e745f64152922a2a6d4d9edab6fbaa8a07ae8f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/voktlabs/homebrew-vokt/releases/download/v2.0.69/vokt-linux-arm64"
      sha256 "0227ded17d237e216418f7d379b5306bbb4a1742578276f87f85a51eef56e823"
    else
      url "https://github.com/voktlabs/homebrew-vokt/releases/download/v2.0.69/vokt-linux-amd64"
      sha256 "40d49687a2af83f2ba4f88e0acce2fcaa244cfb142738cc722e834c8485f6079"
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
