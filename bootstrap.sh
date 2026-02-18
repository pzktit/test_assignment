#!/usr/bin/env bash
set -e

echo "Installing uv..."

if ! command -v uv &> /dev/null
then
    curl -Ls https://astral.sh/uv/install.sh | sh
    export PATH="$HOME/.local/bin:$PATH"
fi

echo "Syncing environment..."
uv sync
echo "Installing VS Code extensions..."

code --install-extension ms-python.python || true
code --install-extension ms-python.debugpy || true
code --install-extension ms-toolsai.jupyter || true
code --install-extension ms-python.vscode-pylance || true

echo "Environment ready."
