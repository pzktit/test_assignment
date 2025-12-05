#!/usr/bin/env bash
set -e

echo "📦 Setting up Python virtual environment..."

# 1. Create venv only if missing
if [ ! -d .venv ]; then
    echo "🟢 Creating virtual environment (.venv)"
    uv venv .venv
else
    echo "ℹ️ Virtual environment already exists — skipping creation"
fi

# 2. Activate venv
echo "⚙️ Activating .venv"
# Works in bash, zsh, Codespaces, VS Code integrated terminal
source .venv/bin/activate

# 3. Install dependencies
if [ -f requirements.txt ]; then
    echo "📚 Installing dependencies from requirements.txt"
    uv pip install --link-mode=copy -r requirements.txt
else
    echo "⚠️ No requirements.txt found — skipping installation"
fi

# 4. Register Jupyter kernel
echo "🧪 Registering Jupyter kernel"
python -m ipykernel install --user --name cryptopy --display-name "Python (CryptCourse)"

echo "🎉 Environment ready! Virtual env activated ✔"
