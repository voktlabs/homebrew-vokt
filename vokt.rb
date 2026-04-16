# Homebrew Formula for Vokt
# To install: brew install maneeshchaturvedi/vokt/vokt

class Vokt < Formula
  desc "Behavioral code analysis — call graphs, risk scores, blast radius"
  homepage "https://github.com/maneeshchaturvedi/homebrew-vokt"
  version "2.0.38"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/maneeshchaturvedi/homebrew-vokt/releases/download/v2.0.38/vokt-darwin-arm64"
      sha256 "edc7b020bfa42811ec757b5461ecb037569491a5f394098872d50630171adfbb"
    else
      url "https://github.com/maneeshchaturvedi/homebrew-vokt/releases/download/v2.0.38/vokt-darwin-amd64"
      sha256 "9280ced7f646c0b0ab2a10638719a86ba121320e7b0ed7c85e175d4f5bfb43cd"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/maneeshchaturvedi/homebrew-vokt/releases/download/v2.0.38/vokt-linux-arm64"
      sha256 "65f7c886f4f51b78175f3d5ad528d847411a2b777a34a830be285a43b08037e1"
    else
      url "https://github.com/maneeshchaturvedi/homebrew-vokt/releases/download/v2.0.38/vokt-linux-amd64"
      sha256 "7e21226ea63f56f5c94d0b54cd6ed643efe3e8c7e01868fcb809d059703daafe"
    end
  end

  # Java engine (platform-independent) for Java/JVM analysis
  resource "java-engine" do
    url "https://github.com/maneeshchaturvedi/homebrew-vokt/releases/download/v2.0.38/vokt-java-engine.jar"
  end

  # Tai-e runtime (LGPL, kept separate) — tarball of JARs
  resource "tai-e-deps" do
    url "https://github.com/maneeshchaturvedi/homebrew-vokt/releases/download/v2.0.38/tai-e-deps.tar.gz"
  end

  def install
    bin.install "vokt-darwin-arm64" => "vokt" if Hardware::CPU.arm? && OS.mac?
    bin.install "vokt-darwin-amd64" => "vokt" if Hardware::CPU.intel? && OS.mac?
    bin.install "vokt-linux-arm64" => "vokt" if Hardware::CPU.arm? && OS.linux?
    bin.install "vokt-linux-amd64" => "vokt" if Hardware::CPU.intel? && OS.linux?

    # Place Java engine JAR next to the binary
    resource("java-engine").stage { bin.install "vokt-java-engine.jar" }

    # Extract Tai-e runtime JARs into tai-e/ directory next to the binary
    (bin/"tai-e").mkpath
    resource("tai-e-deps").stage do
      (bin/"tai-e").install Dir["*.jar"]
    end
  end

  test do
    assert_match "vokt", shell_output("#{bin}/vokt --version")
  end
end
