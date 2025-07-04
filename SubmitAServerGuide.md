# Submit a Server Guide

This guide explains how to submit your MCP server to the registry using the pre-compiled `publisher` tool.

## Instructions

### 1. Download the Publisher Tool

Download the appropriate `publisher` executable for your operating system from our latest [GitHub Release](https://github.com/modelcontextprotocol/registry/releases/latest).

### 2. Create Your Server's JSON File

Create a `server.json` file to describe your MCP server. Make sure the `repository.url` points to a GitHub repository that you own.

**Example `server.json`:**
```json
{
    "description": "A brief description of your amazing MCP server.",
    "name": "io.github.YOUR_GITHUB_USERNAME/YOUR_REPO_NAME",
    "packages": [
        {
            "registry_name": "npm",
            "name": "your-package-name",
            "version": "1.0.0"
        }
    ],
    "repository": {
        "url": "https://github.com/YOUR_GITHUB_USERNAME/YOUR_REPO_NAME",
        "source": "github"
    },
    "version_detail": {
        "version": "1.0.0"
    }
}
```

### 3. Run the Publisher

Open your terminal, navigate to the directory where you downloaded the files, and run the appropriate command for your operating system:

**macOS (Apple Silicon):**
```bash
chmod +x ./publisher/publisher-darwin-arm64
./publisher/publisher-darwin-arm64 --mcp-file ./server.json --registry-url https://registry.mcpcentral.io
```

**macOS (Intel):**
```bash
chmod +x ./publisher/publisher-darwin-amd64
./publisher/publisher-darwin-amd64 --mcp-file ./server.json --registry-url https://registry.mcpcentral.io
```

**Linux:**
```bash
chmod +x ./publisher/publisher-linux-amd64
./publisher/publisher-linux-amd64 --mcp-file ./server.json --registry-url https://registry.mcpcentral.io
```

**Windows:**
```bash
./publisher/publisher-windows-amd64.exe --mcp-file ./server.json --registry-url https://registry.mcpcentral.io
```

The tool will guide you through a one-time browser authentication with GitHub. After you authorize the app, your server will be published!
