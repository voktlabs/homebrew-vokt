# Homebrew Formula for Vokt
# To install: brew install maneeshchaturvedi/vokt/vokt

class Vokt < Formula
  desc "Behavioral code analysis — call graphs, risk scores, blast radius"
  homepage "https://github.com/maneeshchaturvedi/homebrew-vokt"
  version "2.0.43"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/maneeshchaturvedi/homebrew-vokt/releases/download/v2.0.43/vokt-darwin-arm64"
      sha256 "abd0af84738067618716f79a4f5e5828fc25739e3cebdb0f427c66a4f2e3c3f9"

      resource "go-toolchain" do
        url "https://go.dev/dl/go1.25.0.darwin-arm64.tar.gz"
        sha256 "544932844156d8172f7a28f77f2ac9c15a23046698b6243f633b0a0b00c0749c"
      end
    else
      url "https://github.com/maneeshchaturvedi/homebrew-vokt/releases/download/v2.0.43/vokt-darwin-amd64"
      sha256 "e79929f62af02d9a6eeef40a419bf62e31fb6ba00ea1b5326c907bad05431d8d"

      resource "go-toolchain" do
        url "https://go.dev/dl/go1.25.0.darwin-amd64.tar.gz"
        sha256 "5bd60e823037062c2307c71e8111809865116714d6f6b410597cf5075dfd80ef"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/maneeshchaturvedi/homebrew-vokt/releases/download/v2.0.43/vokt-linux-arm64"
      sha256 "fa6408571de9bd6860c25541bed39148041f68d28984e47394555826860bc56b"

      resource "go-toolchain" do
        url "https://go.dev/dl/go1.25.0.linux-arm64.tar.gz"
        sha256 "05de75d6994a2783699815ee553bd5a9327d8b79991de36e38b66862782f54ae"
      end
    else
      url "https://github.com/maneeshchaturvedi/homebrew-vokt/releases/download/v2.0.43/vokt-linux-amd64"
      sha256 "7bece15d45ab39ea7fbd62d48fbc556d9a8004e207934be057293a4bd57849ab"

      resource "go-toolchain" do
        url "https://go.dev/dl/go1.25.0.linux-amd64.tar.gz"
        sha256 "2852af0cb20a13139b3448992e69b868e50ed0f8a1e5940ee1de9e19a123b613"
      end
    end
  end

  # Java engine (platform-independent) for Java/JVM analysis
  resource "java-engine" do
    url "https://github.com/maneeshchaturvedi/homebrew-vokt/releases/download/v2.0.43/vokt-java-engine.jar"
  end

  # Tai-e runtime (LGPL, kept separate) — tarball of JARs
  resource "tai-e-deps" do
    url "https://github.com/maneeshchaturvedi/homebrew-vokt/releases/download/v2.0.43/tai-e-deps.tar.gz"
  end

  def install
    bin.install "vokt-darwin-arm64" => "vokt" if Hardware::CPU.arm? && OS.mac?
    bin.install "vokt-darwin-amd64" => "vokt" if Hardware::CPU.intel? && OS.mac?
    bin.install "vokt-linux-arm64" => "vokt" if Hardware::CPU.arm? && OS.linux?
    bin.install "vokt-linux-amd64" => "vokt" if Hardware::CPU.intel? && OS.linux?

    resource("java-engine").stage { bin.install "vokt-java-engine.jar" }

    (bin/"tai-e").mkpath
    resource("tai-e-deps").stage do
      (bin/"tai-e").install Dir["*.jar"]
    end

    # Go tarball extracts as go/ — Homebrew strips the single top-level dir,
    # so staging contains bin/, src/, pkg/ directly. Install into lib/vokt/go/.
    (lib/"vokt/go").mkpath
    resource("go-toolchain").stage do
      (lib/"vokt/go").install Dir["*"]
    end
  end

  def caveats
    <<~EOS
      vokt bundles its own Go toolchain — you do not need Go installed to
      analyze Go projects. If a project requires a newer Go version, vokt
      will auto-download it on first use (via GOTOOLCHAIN=auto).

      Java analysis requires Java 17+. Set JAVA_HOME if java is not in PATH.
    EOS
  end

  test do
    assert_match "vokt", shell_output("#{bin}/vokt --version")
    assert_predicate lib/"vokt/go/bin/go", :executable?
  end
end
