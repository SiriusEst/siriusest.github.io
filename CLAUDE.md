# CLAUDE.md

## Project Overview

Quarto-based personal blog ("Sirius Blog") hosted via GitHub Pages. Main content is bilingual (Chinese/English) math notes under `Mathematical-Foundations-of-Machine-Learning/`.

## Git Push Guidelines

- **Commit messages**: Use short, descriptive English messages. Describe the *what* (e.g., "Add optimization dynamics chapter", "Fix typo in orthogonality note"). Do not use generic messages like "Update" or "Changes".
- **Scope**: Each commit should cover one logical change — one new note, one round of edits to a note, or one structural change.
- **Staging**: Only stage files you intentionally changed. Never `git add -A` blindly — check `git status` first to avoid committing temp files or build artifacts.
- **Branch**: Work on `main` unless experimenting with site structure.
- **Before pushing**: Verify that new `.md` files are linked in `Mathematical-Foundations-of-Machine-Learning/index.qmd`.

## Site Design

- Styling lives in `theme.scss` (layered on cosmo): night-sky navbar, banner and footer; Apple system fonts (SF Pro / PingFang SC / SF Mono).
- `filters/sirius.lua` turns the note conventions below into styled markup at render time (H1 → banner title, `## N. 中文 (English)` → numbered heading, `**Definition.**` etc. → labelled blocks). Keep writing plain Markdown; don't hand-write that HTML in notes.
- Formulas render with MathJax 4 in the STIX Two font (`_includes/mathjax.html` plus `html-math-method` in `_quarto.yml`). The filter adds font preload hints on pages with math; when bumping MathJax, update the version in both `_quarto.yml` and `MATHJAX_HINTS` in the filter.
- `index.qmd`, the section `index.qmd` files and `about.qmd` are hand-written HTML blocks using `s-` classes. When adding a note, copy an existing `<li>` row in its section index, and update the Home page's "Recently updated" list.

## Markdown Writing Conventions

### Structure

- Each note starts with a bilingual H1 title: `# 中文标题 (English Title)`
- Immediately below the H1, include: `<div class="updated-time">Updated: YYYY-MM-DD HH:MM AEDT</div>`
- Include the tag legend line after the updated-time div:
  `标签约定：\`Definition\` 表示定义，\`Theory\` 表示理论/定理，\`Inference\` 仅表示推导步骤，\`Result\` 表示结论或应用结论。`
- Sections use `## N. 中文标题 (English Title)` numbering format.

### Content Labels

Use bold labels to mark the role of each block:

- **Definition.** — definitions
- **Theory.** — theorems or principles
- **Inference.** — derivation steps
- **Result.** — conclusions or application takeaways

### Math

- Use `$$...$$` for display math (with blank lines before and after the `$$` delimiters).
- Use `$...$` for inline math.
- Prefer standard LaTeX commands (`\nabla`, `\langle`, `\rangle`, etc.).

### Language

- Note body is bilingual: Chinese main text with English terms in parentheses on first mention.
- Section headings are bilingual: `## N. 中文 (English)`.
- The index page (`index.qmd`) uses English for descriptions and link text.

### File Naming

- Notes are numbered: `N Title.md` (e.g., `6 SGD, Momentum, and Potential Dynamics.md`).
- When adding a new note, also add it to `Mathematical-Foundations-of-Machine-Learning/index.qmd`.
