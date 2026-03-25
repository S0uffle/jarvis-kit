#!/bin/bash
# Jarvis Kit - Setup Script (macOS / Linux)
# Tạo Python virtual environment và cài dependencies

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
VENV_DIR="$SCRIPT_DIR/.venv"

echo "=== Jarvis Kit Setup ==="

# Yêu cầu: Python >= 3.13
REQUIRED_MAJOR=3
REQUIRED_MINOR=13

# Tìm Python: ưu tiên python3 > python
PYTHON_CMD=""
for cmd in "python3" "python"; do
    if command -v "$cmd" &> /dev/null; then
        PYTHON_CMD="$cmd"
        break
    fi
done

if [ -z "$PYTHON_CMD" ]; then
    echo "ERROR: Không tìm thấy Python. Cài Python >= ${REQUIRED_MAJOR}.${REQUIRED_MINOR} trước."
    echo ""
    echo "Cách cài:"
    echo "  macOS:  brew install python@${REQUIRED_MAJOR}.${REQUIRED_MINOR}"
    echo "  Ubuntu: sudo apt install python${REQUIRED_MAJOR}.${REQUIRED_MINOR} python${REQUIRED_MAJOR}.${REQUIRED_MINOR}-venv"
    exit 1
fi

PYTHON_MAJOR=$($PYTHON_CMD -c "import sys; print(sys.version_info.major)")
PYTHON_MINOR=$($PYTHON_CMD -c "import sys; print(sys.version_info.minor)")
PYTHON_VERSION="${PYTHON_MAJOR}.${PYTHON_MINOR}"
echo "Dùng: $PYTHON_CMD (Python $PYTHON_VERSION)"

if [ "$PYTHON_MAJOR" -lt "$REQUIRED_MAJOR" ] || { [ "$PYTHON_MAJOR" -eq "$REQUIRED_MAJOR" ] && [ "$PYTHON_MINOR" -lt "$REQUIRED_MINOR" ]; }; then
    echo ""
    echo "ERROR: Yêu cầu Python >= ${REQUIRED_MAJOR}.${REQUIRED_MINOR}, bạn đang dùng ${PYTHON_VERSION}."
    echo ""
    echo "Cách cài Python ${REQUIRED_MAJOR}.${REQUIRED_MINOR} song song (không ảnh hưởng bản hiện tại):"
    echo "  macOS:  brew install python@${REQUIRED_MAJOR}.${REQUIRED_MINOR}"
    echo "  Ubuntu: sudo apt install python${REQUIRED_MAJOR}.${REQUIRED_MINOR} python${REQUIRED_MAJOR}.${REQUIRED_MINOR}-venv"
    exit 1
fi

# Tạo venv
if [ -d "$VENV_DIR" ]; then
    echo "venv đã tồn tại tại $VENV_DIR — bỏ qua tạo mới."
else
    echo "Tạo virtual environment tại $VENV_DIR (Python $PYTHON_VERSION) ..."
    $PYTHON_CMD -m venv "$VENV_DIR"
fi

# Cài dependencies
echo "Cài dependencies..."
"$VENV_DIR/bin/pip" install --upgrade pip -q
"$VENV_DIR/bin/pip" install -r "$SCRIPT_DIR/requirements.txt" -q

echo ""
echo "=== Setup hoàn tất ==="
echo "venv: $VENV_DIR"
echo ""
echo "Bước tiếp theo:"
echo "  1. Authenticate BigQuery: gcloud auth application-default login"
echo "  2. Mở folder này trong VSCode và bắt đầu dùng Jarvis"
