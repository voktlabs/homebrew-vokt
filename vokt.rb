# Homebrew Formula for Vokt
# To install: brew install maneeshchaturvedi/vokt/vokt

class Vokt < Formula
  desc "Behavioral code analysis — call graphs, risk scores, blast radius"
  homepage "https://github.com/maneeshchaturvedi/homebrew-vokt"
  version "2.0.37"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/maneeshchaturvedi/homebrew-vokt/releases/download/v2.0.37/vokt-darwin-arm64"
      sha256 "5f42380a9f9ed648c2612534a3783bea6ecfc36983663f5131df049b72547acf"
    else
      url "https://github.com/maneeshchaturvedi/homebrew-vokt/releases/download/v2.0.37/vokt-darwin-amd64"
      sha256 "d1a23fc2b56edc1fec8c7fad3b799fae233c292fa9898883df92d5457e7c6e24"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/maneeshchaturvedi/homebrew-vokt/releases/download/v2.0.37/vokt-linux-arm64"
      sha256 "e4b885c47bf713240c83a097a3f1dfaa26000f8b441e6823d14478be804257d0"
    else
      url "https://github.com/maneeshchaturvedi/homebrew-vokt/releases/download/v2.0.37/vokt-linux-amd64"
      sha256 "08a5b1d311b1736e62ab00fbf713784c4374093cb9e988ce49fd89c64f713782"
    end
  end

  # Java engine (platform-independent) for Java/JVM analysis
  resource "java-engine" do
    url "https://github.com/maneeshchaturvedi/homebrew-vokt/releases/download/v2.0.37/vokt-java-engine.jar"
  end

  # Tai-e runtime (LGPL, kept separate) — tarball of JARs
  resource "tai-e-deps" do
    url "https://github.com/maneeshchaturvedi/homebrew-vokt/releases/download/v2.0.37/tai-e-deps.tar.gz"
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
