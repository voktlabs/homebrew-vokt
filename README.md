# Package Repository for Vokt

Official package repository for Vokt — behavioral code analysis for Go and Java codebases. Supports Homebrew (macOS/Linux) and Chocolatey (Windows).

## Installation

### macOS/Linux (Homebrew)

```bash
brew tap voktlabs/vokt
brew install vokt
```

### Windows (Chocolatey)

Download the latest `.nupkg` file from [releases](https://github.com/voktlabs/homebrew-vokt/releases) and install:

```powershell
# Navigate to the directory containing the .nupkg file
choco install vokt-cli -s . -y
```

## About Vokt

Vokt builds precise call graphs for Go and Java codebases using SSA/VTA and pointer analysis. It computes risk scores, blast radius, hub detection, and behavioral facts for every function — giving developers and AI coding assistants the context they need to make safe changes.

### Features

- **Call Graph Analysis** — Precise call graphs using VTA (Go) and pointer analysis (Java)
- **Risk Scoring** — Composite risk scores from blast radius, hub centrality, churn, bus factor, and complexity
- **Blast Radius** — Confidence-weighted impact analysis for any function
- **Hub Detection** — Identify the most central functions in the codebase
- **Behavioral Facts** — Guards, mutations, error flows, and purity for every function
- **MCP Server** — Integrates with AI coding assistants (Claude Code) via Model Context Protocol
- **Change Validation** — Detect removed guards, swallowed errors, and purity regressions

## Links

- [Releases](https://github.com/voktlabs/homebrew-vokt/releases)
- [Issues](https://github.com/voktlabs/homebrew-vokt/issues)

## License

MIT
