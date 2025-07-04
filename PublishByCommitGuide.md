# Publish-by-Commit Workflow Guide

This guide explains how to set up a seamless, repository-based submission process for your MCP registry. This workflow allows users to publish their servers by simply committing a `mcp-server.json` file to their repository.

## Overview

The "Publish-by-Commit" workflow is a Git-based approach that eliminates the need for a separate CLI tool. It leverages GitHub webhooks to automatically detect changes to a server's manifest file and update the registry accordingly.

### How it Works

1.  **Standardized Manifest:** A `mcp-server.json` file in the root of a user's repository serves as the official manifest for their MCP server.
2.  **GitHub Webhook:** A webhook is configured in your GitHub App to send a `push` event to your registry's webhook receiver whenever a commit is pushed to the default branch of a repository that has installed the app.
3.  **Webhook Receiver:** A dedicated service in your registry application listens for these webhook events.
4.  **Automatic Publishing:** When the webhook receiver is notified of a change to the `mcp-server.json` file, it automatically fetches the file, parses it, and updates the server's entry in the registry.

## Implementation Steps

### 1. Create a Webhook Receiver

You will need to create a new service in your registry application that can receive and process webhook events from GitHub. This service should be exposed at a new endpoint (e.g., `/v0/hooks/github`).

The receiver should be able to:
*   Verify the webhook signature to ensure the request is from GitHub.
*   Parse the webhook payload to identify the repository and the modified files.
*   If the `mcp-server.json` file was modified, fetch its contents from the repository.
*   Add or update the server entry in your registry's database.

### 2. Configure the GitHub App

You will need to configure your GitHub App to send `push` events to your webhook receiver.

1.  **Navigate to Your GitHub App Settings:**
    *   Go to your GitHub profile settings.
    *   In the left sidebar, click **Developer settings**.
    *   Click **GitHub Apps**, then select your app.

2.  **Configure the Webhook:**
    *   In the "Webhook" section, set the **Webhook URL** to the endpoint you created in the previous step (e.g., `https://registry.mcpcentral.io/v0/hooks/github`).
    *   Create a **Webhook secret** and store it securely. Your application will use this to verify the authenticity of the webhook events.
    *   Under "Permissions & events", ensure that you have subscribed to **Push** events.

### 3. The "Invite-by-PR" Flow

This setup enables a powerful "invite-by-PR" workflow:

1.  Discover a new MCP server on GitHub.
2.  Fork the repository.
3.  Add a `mcp-server.json` file to the root of your fork.
4.  Open a pull request to the original repository.
5.  If the owner accepts your PR, the `mcp-server.json` file is merged, a `push` event is triggered, and the server is automatically published to your registry.
