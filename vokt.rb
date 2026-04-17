# Homebrew Formula for Vokt
# To install: brew install maneeshchaturvedi/vokt/vokt

class Vokt < Formula
  desc "Behavioral code analysis — call graphs, risk scores, blast radius"
  homepage "https://github.com/maneeshchaturvedi/homebrew-vokt"
  version "2.0.40"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/maneeshchaturvedi/homebrew-vokt/releases/download/v2.0.40/vokt-darwin-arm64"
      sha256 "efd1bf5adb449af277476ce4b9ff2a258bb91d18cf998391e82685b7bd67560e"
    else
      url "https://github.com/maneeshchaturvedi/homebrew-vokt/releases/download/v2.0.40/vokt-darwin-amd64"
      sha256 "acdd8d0f835956b54080151645d04f79510c289d375bfb1d248e51f12ec97806"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/maneeshchaturvedi/homebrew-vokt/releases/download/v2.0.40/vokt-linux-arm64"
      sha256 "4b55473060669bc092256c868a4f8827dc35b580688fdd47b18b502c89379c54"
    else
      url "https://github.com/maneeshchaturvedi/homebrew-vokt/releases/download/v2.0.40/vokt-linux-amd64"
      sha256 "0d9713e29a211a582e314cf9e85ed1af728832ff13ee35fcdc6c4569eb3e05d6"
    end
  end

  # Java engine (platform-independent) for Java/JVM analysis
  resource "java-engine" do
    url "https://github.com/maneeshchaturvedi/homebrew-vokt/releases/download/v2.0.40/vokt-java-engine.jar"
  end

  # Tai-e runtime (LGPL, kept separate) — tarball of JARs
  resource "tai-e-deps" do
    url "https://github.com/maneeshchaturvedi/homebrew-vokt/releases/download/v2.0.40/tai-e-deps.tar.gz"
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
