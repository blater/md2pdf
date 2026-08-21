# md2pdf

A small, self-contained command-line utility that turns Markdown into a polished
PDF. It uses Pandoc for accurate Markdown parsing and WeasyPrint for high-quality
paged HTML/CSS rendering. The print stylesheet is embedded in the script, so
there are no themes or support files to install.

## Usage

```text
md2pdf [options] INPUT.md [OUTPUT.pdf]
```

Options include:

- `-o, --output FILE` — write the PDF to `FILE`
- `--title TEXT` — set the document title
- `--toc` — add a table of contents
- `--number-sections` — number headings
- `--page-size SIZE` — use A4, Letter, Legal, A5, or A3
- `--margin LENGTH` — set the page margin, such as `20mm` or `0.75in`
- `--css FILE` — append a custom stylesheet

The default output is beside the source file with a `.pdf` extension.

```sh
./md2pdf README.md
./md2pdf --toc --number-sections report.md report.pdf
./md2pdf --page-size Letter --margin 0.75in notes.md
./md2pdf --css company.css -o handout.pdf handout.md
```

Run `./md2pdf --help` for all options.

## Install

```sh
brew install blater/tap/md2pdf
```

## Markdown features

Pandoc Markdown supports headings, lists, task lists, tables, fenced code blocks
with syntax highlighting, block quotes, footnotes, links, images, document
metadata, and raw HTML. Relative image paths are resolved from the Markdown
file's directory and embedded before the PDF is rendered.

A YAML metadata block gives the PDF a title page header:

```yaml
---
title: Quarterly Review
subtitle: Engineering and Operations
author: Ada Example
date: 21 August 2026
---
```

Insert `<div class="page-break"></div>` to force a new page. A custom stylesheet
passed with `--css` is loaded after the built-in stylesheet, so it can override
fonts, colours, spacing, and other presentation details.

## Design notes

Conversion is atomic: the final path is replaced only after both conversion
stages succeed. Temporary HTML, embedded resources, and the intermediate PDF are
removed automatically. The built-in print stylesheet includes page numbers,
balanced typography, repeating table headers, code wrapping, image scaling, and
rules to reduce awkward page breaks.
