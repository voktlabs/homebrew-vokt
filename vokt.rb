# Homebrew Formula for Vokt
# To install: brew install maneeshchaturvedi/vokt/vokt

class Vokt < Formula
  desc "Behavioral code analysis — call graphs, risk scores, blast radius"
  homepage "https://github.com/maneeshchaturvedi/homebrew-vokt"
  version "2.0.34"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/maneeshchaturvedi/homebrew-vokt/releases/download/v2.0.34/vokt-darwin-arm64"
      sha256 "4b572ed470b8f3c09b562ced923484546fea1a252aedde0634491a647cb05b18"
    else
      url "https://github.com/maneeshchaturvedi/homebrew-vokt/releases/download/v2.0.34/vokt-darwin-amd64"
      sha256 "a52f0b1dce334756ff2913be9435546233aa9f4874b8990a0ca1800ccf7ead9f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/maneeshchaturvedi/homebrew-vokt/releases/download/v2.0.34/vokt-linux-arm64"
      sha256 "ef9a9a9621b26d0f1e23a938b29fb7ca41f3a33573b11c59dbb11d27356d0485"
    else
      url "https://github.com/maneeshchaturvedi/homebrew-vokt/releases/download/v2.0.34/vokt-linux-amd64"
      sha256 "479bfdd357ad575d1e1135290f03d5390a6c66db028984ebca287055a0eb1acb"
    end
  end

  # Java engine JARs (platform-independent) for Java/JVM analysis
  resource "java-engine" do
    url "https://github.com/maneeshchaturvedi/homebrew-vokt/releases/download/v2.0.34/vokt-java-engine.jar"
  end

  resource "tai-e" do
    url "https://github.com/maneeshchaturvedi/homebrew-vokt/releases/download/v2.0.34/tai-e-all.jar"
  end

  def install
    bin.install "vokt-darwin-arm64" => "vokt" if Hardware::CPU.arm? && OS.mac?
    bin.install "vokt-darwin-amd64" => "vokt" if Hardware::CPU.intel? && OS.mac?
    bin.install "vokt-linux-arm64" => "vokt" if Hardware::CPU.arm? && OS.linux?
    bin.install "vokt-linux-amd64" => "vokt" if Hardware::CPU.intel? && OS.linux?

    # Place Java engine JARs next to the binary so vokt finds them automatically
    resource("java-engine").stage { bin.install "vokt-java-engine.jar" }
    resource("tai-e").stage { bin.install "tai-e-all.jar" }
  end

  test do
    assert_match "vokt", shell_output("#{bin}/vokt --version")
  end
end
