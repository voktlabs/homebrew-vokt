# Homebrew Formula for Vokt
# To install: brew install maneeshchaturvedi/vokt/vokt

class Vokt < Formula
  desc "AI-powered specification-driven development for legacy code"
  homepage "https://github.com/maneeshchaturvedi/homebrew-vokt"
  version "2.0.26"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/maneeshchaturvedi/homebrew-vokt/releases/download/v2.0.26/vokt-darwin-arm64"
      sha256 "997a4fcbb08cdbd040e992b4ff1c44914efc6196c55e46b4aebfd65df8662b1a"
    else
      url "https://github.com/maneeshchaturvedi/homebrew-vokt/releases/download/v2.0.26/vokt-darwin-amd64"
      sha256 "7ab32caa75b6dd12e1d2214cbfdb4b00059bbbbf928219f1b5a7bce6c6a7fd45"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/maneeshchaturvedi/homebrew-vokt/releases/download/v2.0.26/vokt-linux-arm64"
      sha256 "9eba47f210f59e81cf48fb8e224ce3e22fe6dcd116c19b28e9015b4fe3b5ccc6"
    else
      url "https://github.com/maneeshchaturvedi/homebrew-vokt/releases/download/v2.0.26/vokt-linux-amd64"
      sha256 "3a9337de54d24305ef1767d316706f1464348d16a82893bd3a54916f4c39857c"
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
