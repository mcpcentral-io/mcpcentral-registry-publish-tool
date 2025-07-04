#!/bin/bash

# Test script for SubmitAServerGuide.md

echo "=== MCP Registry Publisher Test Script ==="
echo

# Test 1: Check if publisher directory exists
echo "Test 1: Checking for publisher directory..."
if [ -d "publisher" ]; then
    echo "✓ Publisher directory found"
else
    echo "✗ Publisher directory not found"
    echo "  Please download the publisher tool from GitHub releases"
fi
echo

# Test 2: Check for publisher executables
echo "Test 2: Checking for publisher executables..."
FOUND_EXECUTABLE=false
for exe in "publisher-darwin-arm64" "publisher-darwin-amd64" "publisher-linux-amd64" "publisher-windows-amd64.exe"; do
    if [ -f "publisher/$exe" ]; then
        echo "✓ Found: $exe"
        FOUND_EXECUTABLE=true
    fi
done
if [ "$FOUND_EXECUTABLE" = false ]; then
    echo "✗ No publisher executables found"
fi
echo

# Test 3: Check for server.json
echo "Test 3: Checking for server.json..."
if [ -f "server.json" ]; then
    echo "✓ server.json found"
    
    # Validate JSON structure
    if command -v jq &> /dev/null; then
        echo "  Validating JSON structure..."
        if jq . server.json &> /dev/null; then
            echo "  ✓ Valid JSON"
            
            # Check required fields
            MISSING_FIELDS=()
            for field in "description" "name" "packages" "repository" "version_detail"; do
                if ! jq -e ".$field" server.json &> /dev/null; then
                    MISSING_FIELDS+=("$field")
                fi
            done
            
            if [ ${#MISSING_FIELDS[@]} -eq 0 ]; then
                echo "  ✓ All required fields present"
            else
                echo "  ✗ Missing fields: ${MISSING_FIELDS[*]}"
            fi
            
            # Check GitHub URL
            REPO_URL=$(jq -r '.repository.url' server.json 2>/dev/null)
            if [[ "$REPO_URL" == "https://github.com/"* ]]; then
                echo "  ✓ Valid GitHub repository URL"
            else
                echo "  ✗ Repository URL should start with https://github.com/"
            fi
        else
            echo "  ✗ Invalid JSON format"
        fi
    else
        echo "  ⚠ jq not installed - skipping JSON validation"
    fi
else
    echo "✗ server.json not found"
    echo "  Creating example server.json..."
    cat > server.json << 'EOF'
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
EOF
    echo "  ✓ Created example server.json"
fi
echo

# Test 4: Detect OS and suggest appropriate command
echo "Test 4: Detecting OS and suggesting command..."
OS_TYPE=""
PUBLISHER_EXEC=""

if [[ "$OSTYPE" == "darwin"* ]]; then
    # Check if Apple Silicon or Intel
    if [[ "$(uname -m)" == "arm64" ]]; then
        OS_TYPE="macOS (Apple Silicon)"
        PUBLISHER_EXEC="./publisher/publisher-darwin-arm64"
    else
        OS_TYPE="macOS (Intel)"
        PUBLISHER_EXEC="./publisher/publisher-darwin-amd64"
    fi
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS_TYPE="Linux"
    PUBLISHER_EXEC="./publisher/publisher-linux-amd64"
elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]] || [[ "$OSTYPE" == "win32" ]]; then
    OS_TYPE="Windows"
    PUBLISHER_EXEC="./publisher/publisher-windows-amd64.exe"
fi

if [ -n "$OS_TYPE" ]; then
    echo "✓ Detected OS: $OS_TYPE"
    echo "  Suggested command:"
    echo "  chmod +x $PUBLISHER_EXEC"
    echo "  $PUBLISHER_EXEC --mcp-file ./server.json --registry-url https://registry.mcpcentral.io"
else
    echo "✗ Could not detect OS type"
fi
echo

# Summary
echo "=== Test Summary ==="
if [ "$FOUND_EXECUTABLE" = true ] && [ -f "server.json" ]; then
    echo "✓ Ready to publish! Run the command above to submit your server."
else
    echo "✗ Not ready to publish. Please:"
    if [ "$FOUND_EXECUTABLE" = false ]; then
        echo "  - Download the publisher tool from GitHub releases"
    fi
    if [ ! -f "server.json" ]; then
        echo "  - Update the generated server.json with your server details"
    fi
fi