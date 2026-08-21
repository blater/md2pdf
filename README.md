# md2pdf

A small, self-contained command-line utility that turns Markdown into a polished
PDF. It uses Pandoc for accurate Markdown parsing and WeasyPrint for high-quality
paged HTML/CSS rendering. The print stylesheet is embedded in the script, so
there are no themes or support files to install.

## Install

The simplest installation installs `md2pdf` and both runtime dependencies in
one step:

```sh
brew install blater/tap/md2pdf
```

You can also install the script directly. In that case, install its runtime
dependencies first:

```sh
brew install pandoc weasyprint
```

Then put the script somewhere on your `PATH`, for example:

```sh
install -m 755 md2pdf /usr/local/bin/md2pdf
```

On Apple Silicon Macs, `/opt/homebrew/bin` is usually a better destination than
`/usr/local/bin`. You can also run `./md2pdf` directly from this directory.

If Pandoc or WeasyPrint is unavailable and Homebrew is installed, `md2pdf` names
every missing command and offers to install it. Answer `y` at the prompt to
continue, or pass `--install-dependencies` to approve the Homebrew installation
without prompting. If you decline, it prints the command you can run yourself.

## Usage

```text
md2pdf [options] INPUT.md [OUTPUT.pdf]
```

The default output is beside the source file with a `.pdf` extension.

```sh
./md2pdf README.md
./md2pdf --toc --number-sections report.md report.pdf
./md2pdf --page-size Letter --margin 0.75in notes.md
./md2pdf --css company.css -o handout.pdf handout.md
```

Run `./md2pdf --help` for all options.

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
