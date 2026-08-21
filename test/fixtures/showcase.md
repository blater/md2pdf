---
title: Rendering Showcase
subtitle: A compact visual test for md2pdf
author: Example Author
date: 21 August 2026
---

# Introduction

This paragraph contains **bold text**, *italics*, `inline code`, and a
[clickable link](https://example.com). It is long enough to demonstrate the
comfortable measure and line spacing used for body text.

> Good typography should make the structure obvious without distracting from
> the content. Block quotes receive a restrained accent and softer text colour.

## Lists and tasks

1. Parse the Markdown accurately.
2. Apply a print-focused stylesheet.
3. Render the result atomically.

- [x] Headings and prose
- [x] Tables and code
- [ ] A final unchecked task

## Tabular data

| Component | Purpose | Status | Score |
|:----------|:--------|:------:|------:|
| Pandoc | Parse rich Markdown | Ready | 98 |
| WeasyPrint | Render paged CSS | Ready | 96 |
| md2pdf | Coordinate the pipeline | Ready | 97 |

## Source code

```python
from pathlib import Path

def describe(path: Path) -> str:
    """Return a friendly description without clipping long code lines."""
    return f"{path.name}: {path.stat().st_size:,} bytes"
```

## Notes

Images are scaled to fit the printable area, table headers repeat across pages,
and awkward breaks are reduced where the renderer can do so. A footnote rounds
out the sample.[^details]

[^details]: Footnotes use a smaller, quieter style while remaining legible.

