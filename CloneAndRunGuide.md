# Clone and Run Guide

This guide explains how to publish your MCP server to the registry by cloning this repository and running the publisher tool from the source.

## Instructions

### 1. Clone the Repository

Clone this repository to your local machine:

```bash
git clone https://github.com/modelcontextprotocol/mcpcentral-registry-publish-tool.git
cd mcpcentral-registry-publish-tool
```

### 2. Create Your Server's JSON File

Create a `server.json` file in the root of the repository to describe your MCP server. Make sure the `repository.url` points to a GitHub repository that you own.

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

Run the publisher tool from the root of the repository:

```bash
go run ./tools/publisher --mcp-file ./server.json --registry-url https://registry.mcpcentral.io
```

The tool will guide you through a one-time browser authentication with GitHub. After you authorize the app, your server will be published!
