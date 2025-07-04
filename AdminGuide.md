# Admin Guide: Releasing the Publisher Tool

This guide explains how to create a new release for the `publisher` tool and attach the pre-compiled binaries for different operating systems.

There are two ways to create a release: manually through the GitHub UI or automatically using the provided GitHub Actions workflow.

---

### Option 1: Manual Release

This is the most straightforward way to create a release.

1.  **Navigate to Your Repository's Releases Page:**
    *   Go to your repository on GitHub.
    *   On the right-hand side of the page, click on **Releases**.

2.  **Create a New Release:**
    *   Click the **"Draft a new release"** or **"Create a new release"** button.

3.  **Fill in the Release Details:**
    *   **Tag version:** Enter a version number for your release (e.g., `v1.0.0`). It's important to follow a consistent versioning scheme.
    *   **Release title:** Give your release a descriptive title (e.g., "Publisher Tool v1.0.0").
    *   **Description:** Write a brief description of the changes in this release.

4.  **Upload the Binaries:**
    *   First, ensure you have the compiled binaries. If not, run the build script from the root of the repository:
        ```bash
        ./scripts/build_publisher.sh
        ```
    *   In the "Attach binaries by dropping them here or selecting them" section on the release page, drag and drop the `publisher` binaries from the `build/publisher` directory.

5.  **Publish the Release:**
    *   Click the **"Publish release"** button.

---

### Option 2: Automated Release with GitHub Actions

This method automates the entire process. The workflow is triggered whenever you push a new tag that starts with `v` (e.g., `v1.0.1`, `v1.1.0`).

1.  **Ensure the Workflow File Exists:**
    *   Make sure the `.github/workflows/release.yml` file exists in your repository. If not, you can copy it from the original `modelcontextprotocol/registry` repository.

2.  **Commit and Push Your Changes:**
    *   Ensure all your latest code changes are committed and pushed to the main branch.

3.  **Create and Push a New Tag:**
    *   From your local terminal, in your repository's directory, run the following commands to create a new version tag and push it to GitHub:
        ```bash
        # Example for version 1.0.1
        git tag v1.0.1
        git push origin v1.0.1
        ```

4.  **Verify the Release:**
    *   Go to the **"Actions"** tab in your GitHub repository. You will see the "Release Publisher" workflow running.
    *   Once the workflow completes successfully, a new release will be created on your repository's **Releases** page, with all the compiled binaries automatically attached.
