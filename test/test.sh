#!/usr/bin/env bash

set -eu

project_dir=$(cd "$(dirname "$0")/.." && pwd -P)
tmp_dir=$(mktemp -d "${TMPDIR:-/tmp}/md2pdf-test.XXXXXX")
trap 'rm -rf "$tmp_dir"' EXIT HUP INT TERM

fail() {
  printf 'FAIL: %s\n' "$*" >&2
  exit 1
}

"$project_dir/md2pdf" --help | grep -q 'Convert Markdown' || fail '--help output'
"$project_dir/md2pdf" --help | grep -q -- '--install-dependencies' || fail 'dependency installation option'
[[ $("$project_dir/md2pdf" --version) == 'md2pdf 0.1.0' ]] || fail '--version output'

if PATH=/usr/bin:/bin "$project_dir/md2pdf" "$project_dir/README.md" "$tmp_dir/missing.pdf" >"$tmp_dir/stdout" 2>"$tmp_dir/stderr"; then
  fail 'missing dependency check unexpectedly succeeded'
fi
grep -q 'required command(s) not found on PATH' "$tmp_dir/stderr" || fail 'missing dependency message'
grep -q 'brew install' "$tmp_dir/stderr" || fail 'Homebrew installation hint'

if command -v pandoc >/dev/null 2>&1 && command -v weasyprint >/dev/null 2>&1; then
  "$project_dir/md2pdf" --toc --number-sections "$project_dir/test/fixtures/showcase.md" "$tmp_dir/sample.pdf"
  [[ -s "$tmp_dir/sample.pdf" ]] || fail 'PDF was not created'
  file "$tmp_dir/sample.pdf" | grep -q 'PDF document' || fail 'output is not a PDF'
  if command -v pdfinfo >/dev/null 2>&1; then
    pdfinfo "$tmp_dir/sample.pdf" | grep -q 'Title:.*Rendering Showcase' || fail 'PDF title metadata'
  fi
fi

printf 'All tests passed.\n'
