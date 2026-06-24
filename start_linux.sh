#!/usr/bin/env bash
set -e
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR/cfgs_and_internal"

# --- compiled binary (distribution) ---
if [ -f "./pyla_main" ]; then
    chmod +x ./pyla_main
    exec ./pyla_main
fi

# --- run from source ---
VENV_DIR=".venv"

if [ ! -d "$VENV_DIR" ]; then
    echo "Creating virtual environment..."
    python3 -m venv "$VENV_DIR"
fi

source "$VENV_DIR/bin/activate"

if [ -f "requirements.txt" ]; then
    echo "Installing dependencies..."
    pip install -q -r requirements.txt
    pip install -q --no-deps --ignore-requires-python --force-reinstall \
        "git+https://github.com/leng-yue/py-scrcpy-client.git@v0.5.0"
fi

exec python3 main.py
