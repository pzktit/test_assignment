#!/usr/bin/env bash
set -e

echo "📦 Initializing environment..."

# 1. Install uv if missing
if ! command -v uv >/dev/null 2>&1; then
    echo "⬇️ Installing uv..."
    curl -LsSf https://astral.sh/uv/install.sh | sh

    # Ensure PATH persists (this is needed on universal:2)
    export PATH="$HOME/.local/bin:$PATH"
    if ! grep -q '.local/bin' ~/.bashrc; then
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
    fi
fi

# 2. Create venv only if missing
if [ ! -d .venv ]; then
    echo "🟢 Creating .venv"
    uv venv .venv
else
    echo "ℹ️ .venv already exists – skipping creation"
fi

# 3. Activate venv
echo "⚙️ Activating .venv"
source .venv/bin/activate

# 4. Install dependencies
if [ -f supporting_packages.txt ]; then
    echo "📚 Installing dependencies"
    uv pip install -r supporting_packages.txt
fi

# 6️⃣ Add auto-activation of .venv to ~/.bashrc if not already present

VENV_ACTIVATE_LINE="source $(pwd)/.venv/bin/activate"

if ! grep -Fxq "$VENV_ACTIVATE_LINE" "$HOME/.bashrc"; then
    echo "$VENV_ACTIVATE_LINE" >> "$HOME/.bashrc"
    echo "🔗 Added automatic .venv activation to ~/.bashrc"
else
    echo "ℹ️ .venv activation already present in ~/.bashrc — skipping"
fi

echo "🎉 Setup complete!"
