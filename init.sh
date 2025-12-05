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
if [ -f requirements.txt ]; then
    echo "📚 Installing dependencies"
    uv pip install --link-mode=copy -r requirements.txt
fi

# 5. Register Jupyter kernel
python -m ipykernel install --user --name cryptopy --display-name "Python (CryptCourse)"

echo "🎉 Setup complete!"
