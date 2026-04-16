# Homebrew Formula for Vokt
# To install: brew install maneeshchaturvedi/vokt/vokt

class Vokt < Formula
  desc "Behavioral code analysis — call graphs, risk scores, blast radius"
  homepage "https://github.com/maneeshchaturvedi/homebrew-vokt"
  version "2.0.36"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/maneeshchaturvedi/homebrew-vokt/releases/download/v2.0.36/vokt-darwin-arm64"
      sha256 "b32d5ef7b7047c327ed254b48270d100a71fc3dc1b5c72ad3ffc85f407ed1a9d"
    else
      url "https://github.com/maneeshchaturvedi/homebrew-vokt/releases/download/v2.0.36/vokt-darwin-amd64"
      sha256 "00185ca4c9f7f0f6c69da4ed17e49e871a087077bfa5fc8723b6d84c16ae0eac"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/maneeshchaturvedi/homebrew-vokt/releases/download/v2.0.36/vokt-linux-arm64"
      sha256 "8280a23dbe9730ff2abe9e581f97b1f69f70ee31b21b2b71ebe4d9c9f7381fe3"
    else
      url "https://github.com/maneeshchaturvedi/homebrew-vokt/releases/download/v2.0.36/vokt-linux-amd64"
      sha256 "03c815c2beb70bba0a7da0a703cc71c0f01c92998302d923ee933ed7d3ed3161"
    end
  end

  # Java engine (platform-independent) for Java/JVM analysis
  resource "java-engine" do
    url "https://github.com/maneeshchaturvedi/homebrew-vokt/releases/download/v2.0.36/vokt-java-engine.jar"
  end

  # Tai-e runtime (LGPL, kept separate) — tarball of JARs
  resource "tai-e-deps" do
    url "https://github.com/maneeshchaturvedi/homebrew-vokt/releases/download/v2.0.36/tai-e-deps.tar.gz"
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
