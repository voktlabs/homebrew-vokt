# Homebrew Formula for Vokt
# To install: brew install maneeshchaturvedi/vokt/vokt

class Vokt < Formula
  desc "Behavioral code analysis — call graphs, risk scores, blast radius"
  homepage "https://github.com/maneeshchaturvedi/homebrew-vokt"
  version "2.0.39"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/maneeshchaturvedi/homebrew-vokt/releases/download/v2.0.39/vokt-darwin-arm64"
      sha256 "05bec33552dc82397bdeb29213cf2062a5a0cc41d06e9736642d7bd58204b5a3"
    else
      url "https://github.com/maneeshchaturvedi/homebrew-vokt/releases/download/v2.0.39/vokt-darwin-amd64"
      sha256 "6a795b656c9ed5d675b520987ec26733509697b23cad89a8027cd9d728f5d47b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/maneeshchaturvedi/homebrew-vokt/releases/download/v2.0.39/vokt-linux-arm64"
      sha256 "8544ba4f101467fc66f95401bf41023248263369e077b54727d3da26c161f973"
    else
      url "https://github.com/maneeshchaturvedi/homebrew-vokt/releases/download/v2.0.39/vokt-linux-amd64"
      sha256 "6d0d566bd5c17e540e075b02d589cf72de2d39ba47aa57185cc0309e9ecbb3f7"
    end
  end

  # Java engine (platform-independent) for Java/JVM analysis
  resource "java-engine" do
    url "https://github.com/maneeshchaturvedi/homebrew-vokt/releases/download/v2.0.39/vokt-java-engine.jar"
  end

  # Tai-e runtime (LGPL, kept separate) — tarball of JARs
  resource "tai-e-deps" do
    url "https://github.com/maneeshchaturvedi/homebrew-vokt/releases/download/v2.0.39/tai-e-deps.tar.gz"
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
