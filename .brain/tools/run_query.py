#!/usr/bin/env python3
"""
run_query.py - BigQuery Query Wrapper for Jarvis (Optimized)

DECISION GUIDE FOR AI AGENT:

1. INPUT (Query length - dễ phán đoán):
   ┌──────────────────┬───────────────────────────────────────────────┐
   │ --query "..."    │ Query ≤5 dòng, có thể viết inline            │
   │ --file query.sql │ Query >5 dòng, hoặc có CTEs/JOINs phức tạp   │
   └──────────────────┴───────────────────────────────────────────────┘

2. OUTPUT (Result size - CẦN PHÂN TÍCH QUERY để đoán):

   ✅ STDOUT (no --output) - Khi CHẮC CHẮN output ≤100 rows:

   Dấu hiệu query sẽ trả về ÍT rows:
   • Có LIMIT ≤100 rõ ràng
   • GROUP BY + aggregations (COUNT, SUM, AVG) → summary metrics
   • UNION ALL các CTEs aggregated → chỉ vài rows tổng hợp
   • SELECT COUNT(*), COUNT(DISTINCT ...) → 1 row
   • Query phân tích conversion rate, success rate → vài chục rows

   VD: test_query2.sql (67 dòng) nhưng output ~60 rows success rates
       → Dùng stdout (không --output) ✅

   ⚠️ CSV (--output file.csv) - Khi KHÔNG CHẮC hoặc biết output lớn:

   Dấu hiệu query sẽ trả về NHIỀU rows:
   • SELECT * FROM table (không LIMIT) → event-level data
   • LIMIT >100 hoặc LIMIT 1000, 10000
   • Query không có GROUP BY → raw records
   • Export user journeys, events, transactions → hàng nghìn/triệu rows

   VD: test_query.sql → 2.4M rows → BẮT BUỘC --output ✅

   📌 NGUYÊN TẮC AN TOÀN:
   • Nếu KHÔNG CHẮC → dùng --output (an toàn hơn)
   • Nếu output quá lớn bị print ra stdout → user sẽ phải Ctrl+C
   • Agent có thể re-run với --output nếu stdout quá lớn

Sử dụng:
    python3 run_query.py --query "SELECT 1" --output result.csv
    python3 run_query.py --file query.sql --output result.csv
    python3 run_query.py --query "SELECT 1"  # Output to stdout

Environment:
    Yêu cầu: venv tại .venv/ (chạy setup.sh hoặc setup.bat để tạo)
    Script tự detect venv path — hỗ trợ macOS, Linux, Windows.
"""

import argparse
import sys
import os
import subprocess
import tempfile

def _find_venv_python():
    """Tìm Python trong .venv/, hỗ trợ macOS/Linux/Windows."""
    script_dir = os.path.dirname(os.path.abspath(__file__))
    # .brain/tools/ → lùi 2 cấp về root
    kit_root = os.path.dirname(os.path.dirname(script_dir))
    venv_dir = os.path.join(kit_root, ".venv")

    # Windows: .venv/Scripts/python.exe | macOS/Linux: .venv/bin/python
    candidates = [
        os.path.join(venv_dir, "bin", "python"),
        os.path.join(venv_dir, "bin", "python3"),
        os.path.join(venv_dir, "Scripts", "python.exe"),
    ]
    for p in candidates:
        if os.path.exists(p):
            return p
    return None

PYTHON_PATH = _find_venv_python()

def run_query(query: str, output_path: str = None, project: str = None):
    """Chạy query và trả về kết quả."""

    if not PYTHON_PATH:
        print("ERROR: Không tìm thấy .venv/. Chạy setup.sh (macOS/Linux) hoặc setup.bat (Windows) trước.")
        sys.exit(1)

    # Lưu query vào temp file
    with tempfile.NamedTemporaryFile(mode='w', suffix='.sql', delete=False, encoding='utf-8') as f:
        f.write(query)
        query_file = f.name

    # Tạo executor script
    # Script này sẽ đọc query từ file và chạy trên BigQuery
    bq_project = project or os.environ.get("JARVIS_BQ_PROJECT", "")
    if not bq_project:
        print("ERROR: BigQuery project chưa được chỉ định.")
        print("Dùng --project hoặc set env var JARVIS_BQ_PROJECT.")
        sys.exit(1)

    # Convert backslashes to forward slashes for safe embedding in generated script (Windows compat)
    safe_query_file = query_file.replace("\\", "/")
    safe_output_path = (output_path or "").replace("\\", "/")

    executor_script = f'''
import warnings
import sys

# Suppress warnings
warnings.filterwarnings('ignore', message='Your application has authenticated using end user credentials')
warnings.filterwarnings('ignore', message='Unable to find acceptable character detection dependency')

# Read query from file
with open("{safe_query_file}", "r", encoding="utf-8") as f:
    query = f.read()

from google.cloud import bigquery
import pandas as pd

try:
    client = bigquery.Client(project="{bq_project}")
    df = client.query(query).to_dataframe()

    output_path = "{safe_output_path}"

    if output_path:
        # Output dài: save to CSV
        df.to_csv(output_path, index=False)
        print(f"OK: {{len(df)}} rows -> {{output_path}}")
    else:
        # Output ngắn: print to stdout
        print(df.to_csv(index=False))
except Exception as e:
    print(f"ERROR: {{e}}", file=sys.stderr)
    sys.exit(1)
'''

    # Lưu script vào temp file
    with tempfile.NamedTemporaryFile(mode='w', suffix='.py', delete=False, encoding='utf-8') as f:
        f.write(executor_script)
        script_file = f.name

    # Chạy script với direct python path
    try:
        result = subprocess.run(
            [PYTHON_PATH, script_file],
            capture_output=True,
            text=True
        )

        # Print output
        if result.stdout:
            print(result.stdout, end='')
        if result.stderr:
            print(result.stderr, file=sys.stderr, end='')

        return result.returncode

    finally:
        # Cleanup temp files
        try:
            os.unlink(script_file)
            os.unlink(query_file)
        except:
            pass

def main():
    parser = argparse.ArgumentParser(
        description="Chạy BigQuery query (Optimized)",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples với context (để AI agent hiểu khi nào dùng gì):

1. Query metrics (ngắn/ngắn) - Agent cần đọc kết quả:
   User hỏi: "Có bao nhiêu users hôm nay?"
   → python3 run_query.py --query "SELECT COUNT(DISTINCT user_id) FROM events WHERE date = CURRENT_DATE()"
   → Output: "12345" → Agent đọc và trả lời user

2. Quick sample (ngắn/dài) - Data quá lớn để đọc:
   User muốn: "Cho tôi xem 1000 users mẫu"
   → python3 run_query.py --query "SELECT * FROM users LIMIT 1000" --output sample.csv
   → Output: file → Agent nói "đã lưu vào sample.csv"

3. Complex query with summary (dài/ngắn) - Query phức tạp nhưng kết quả gọn:
   User muốn: "Phân tích success rate của các events"
   → python3 run_query.py --file test_query2.sql
   → Query 67 dòng (CTEs + JOINs) nhưng output chỉ ~60 rows (event success rates)
   → Phân tích query: có GROUP BY + COUNT + aggregations → output ngắn
   → Agent đọc success rates và trả lời user

4. Complex query with details (dài/dài) - Cả query lẫn output đều lớn:
   User muốn: "Export toàn bộ user journeys trong tháng"
   → python3 run_query.py --file user_flow.sql --output journeys.csv
   → Query 500 dòng, output 2M rows event-level

Decision Logic (cho AI Agent):
    Input:
        - Query ≤5 dòng → --query
        - Query >5 dòng → --file

    Output (QUAN TRỌNG - phải phân tích query structure):
        - Có GROUP BY + aggregations → likely ≤100 rows → STDOUT ✅
        - Có LIMIT ≤100 → chắc chắn ngắn → STDOUT ✅
        - SELECT * without LIMIT → likely >1000 rows → CSV ⚠️
        - Không chắc → dùng CSV (an toàn) ⚠️

    Examples phân biệt:
        • "SELECT * FROM events LIMIT 1000" → ngắn (1 dòng) nhưng 1000 rows → CSV
        • test_query2.sql → dài (67 dòng) nhưng ~60 rows → STDOUT
        • "SELECT COUNT(*) FROM users" → ngắn + 1 row → STDOUT

Performance:
    - Simple query: ~4s (was 10s) - overhead matters
    - Complex query: ~50s (was 50s) - BigQuery processing dominant
        """
    )

    parser.add_argument("--query", "-q", help="SQL query string (input ngắn)")
    parser.add_argument("--file", "-f", help="Path đến file .sql (input dài)")
    parser.add_argument("--output", "-o", help="Output CSV path (output dài). Không có = stdout (output ngắn)")
    parser.add_argument("--project", "-p", default=None, help="BigQuery project (hoặc set env var JARVIS_BQ_PROJECT)")

    args = parser.parse_args()

    # Validate input
    if not args.query and not args.file:
        parser.error("Cần --query hoặc --file")

    if args.query and args.file:
        parser.error("Chỉ dùng --query HOẶC --file, không dùng cả hai")

    # Validate paths không chứa ký tự gây lỗi injection
    for path_val, path_name in [(args.file, "--file"), (args.output, "--output"), (args.project, "--project")]:
        if path_val and ('"' in path_val or '\\' in path_val):
            parser.error(f'{path_name} không được chứa ký tự " hoặc \\\\')

    # Load query
    if args.file:
        if not os.path.exists(args.file):
            print(f"ERROR: File không tồn tại: {args.file}")
            sys.exit(1)
        with open(args.file, 'r') as f:
            query = f.read()
    else:
        query = args.query

    return run_query(query, args.output, args.project)

if __name__ == "__main__":
    sys.exit(main())
