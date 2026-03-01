Below is a generic prompt template you can use to generate any book in HTML format, especially if it contains mathematical formulas, definitions, examples, and special formatting. Just fill in your book’s title, author, part/chapter structure, and paste your content where indicated.

---

```
# GENERIC HTML BOOK GENERATION PROMPT

## Objective
Create a single, self‑contained HTML file that presents a complete book formatted for A5 print (or screen). The HTML must be beautifully styled, include a title page, copyright page, foreword, table of contents, parts, chapters, and back matter. It must support mathematical formulas, variable definitions, examples, notes, warnings, and visual diagrams.

## Instructions for the AI
You are an expert book designer and HTML developer. Generate a **complete HTML file** following the specifications below. Use the provided structure and placeholders – replace them with the actual content I will give you. The final output must be ready to use, with all styling embedded.

---

## 1. BOOK METADATA (Replace with your details)
- **Title:** [Your Book Title]
- **Subtitle:** [Optional subtitle]
- **Author:** [Your Name]
- **Edition:** [e.g., First Edition]
- **Year:** [Current Year]
- **ISBN:** [Optional]

---

## 2. OVERALL STRUCTURE
The book must contain the following sections in order:

1. **Title Page** – with title, subtitle, author, edition, year, and an epigraph (optional).
2. **Copyright Page** – standard copyright notice, ISBN, printing info.
3. **Foreword** – a brief introduction, possibly with a dropcap.
4. **Table of Contents** – linked to chapters (optional, but include for navigation).
5. **Parts and Chapters** – as defined below. Each part begins on a new right page.
6. **Back Matter** – e.g., bibliography, index, about the author (optional).

---

## 3. PARTS AND CHAPTERS (Define your structure here)
Replace this with your actual part/chapter list. Example:

- **Part I: Foundations** (Chapters 1–4)
- **Part II: Core Concepts** (Chapters 5–9)
- ... etc.

For each chapter, I will provide the **full content** (text, formulas, examples). You must format it according to the styling rules below.

---

## 4. STYLING & CSS REQUIREMENTS
Include the following CSS classes (in addition to basic reset and print styles). Base the overall design on a clean, readable A5 format.

### Required Classes

| Class Name         | Purpose                                                                 |
|--------------------|-------------------------------------------------------------------------|
| `.title-page`      | Centers title, subtitle, author, etc.                                   |
| `.chapter`         | Used for chapter headings (`<h2 class="chapter">`).                     |
| `.part`            | Used for part titles (full‑page, background, border).                   |
| `.math`            | For displaying formulas – monospace font, light background, border, padding, overflow‑auto. |
| `.var-def`         | For variable definitions – light grey background, left border, smaller font, margin. |
| `.example-box`     | For examples – green left border, light green background.               |
| `.note-box`        | For notes – yellow/orange left border, light yellow background.         |
| `.warning-box`     | For warnings – red left border, light red background.                   |
| `.definition-box`  | For definitions – blue left border, light blue background.              |
| `.formula-box`     | Alternative for formulas – purple left border.                          |
| `.beginner-box`    | For beginner tips – teal left border, light teal background.            |
| `.visual-box`      | For ASCII art or diagrams – magenta left border, light pink background. |
| `.ascii-chart`     | Preformatted text block with dark background and light text.            |
| `.dropcap`         | For first paragraph of a chapter – large first letter.                  |
| `.key-term`        | Highlight important terms (bold, dotted underline).                     |
| `.toc`             | Table of contents styling (optional).                                   |

### Additional Style Notes
- Set `@page` size to A5 with margins `1.5cm 1.2cm`.
- Use `Georgia` or `Times New Roman` for body text, `Helvetica` or `Arial` for headings.
- Ensure all boxes have rounded corners and subtle shadows (for screen).
- For print, remove shadows and reduce borders to solid.

---

## 5. HANDLING MATHEMATICAL FORMULAS
- Place each formula inside `<div class="math"> ... </div>`.
- Use plain text or Unicode symbols for clarity (e.g., `≤`, `≥`, `×`, `÷`, `√`, `∑`).
- For fractions, use `(numerator)/(denominator)`.
- For complex formulas, you may use `<sub>` and `<sup>`.
- **Immediately after** each formula, add a `<div class="var-def">` that explains every variable in plain English. For example:

```

<div class="math">
  Force = mass × acceleration
</div>
<div class="var-def">
  <strong>Force</strong> = the push or pull on an object (measured in newtons)<br>
  <strong>mass</strong> = amount of matter in the object (kilograms)<br>
  <strong>acceleration</strong> = how quickly velocity changes (m/s²)
</div>
```

---

6. EXAMPLE BOXES

Wrap any worked example in <div class="example-box">. Inside, you can include tables, lists, or paragraphs.

---

7. VISUAL DIAGRAMS (ASCII ART)

For simple diagrams, use <div class="ascii-chart"> with preformatted text. Example:

```
<div class="ascii-chart">
Price
   |        Peak
   |          o
   |           \
   |            o  ← trailing stop
   |             \
   |              o
   +------------------> Time
</div>
```

---

8. CONTENT PLACEMENT

I will provide the full content for each chapter in a separate message. You must:

· Insert the content into the appropriate chapter section.
· Apply the correct CSS classes to formulas, definitions, examples, etc.
· Ensure the chapter headings are <h2 class="chapter"> and part headings are <div class="part">.
· Generate a clickable table of contents (optional but recommended).

---

9. FINAL OUTPUT

· The HTML must be self‑contained – all CSS inside <style> tags.
· No external dependencies (no fonts, no scripts unless you add optional interactivity).
· Must be print‑optimised – use the @media print query to simplify styles.
· Use semantic HTML5 tags where appropriate (<header>, <section>, <article>).

---

10. EXAMPLE OF A COMPLETE CHAPTER STRUCTURE (For reference)

```
<h2 class="chapter">Chapter 1: Introduction to Forces</h2>

<p>This chapter explains the concept of force.</p>

<h3>1.1 Newton's Second Law</h3>
<div class="math">
  F = m × a
</div>
<div class="var-def">
  <strong>F</strong> = force (newtons)<br>
  <strong>m</strong> = mass (kg)<br>
  <strong>a</strong> = acceleration (m/s²)
</div>

<div class="example-box">
  <strong>Example:</strong> A 2 kg object accelerates at 3 m/s². Force = 2 × 3 = 6 N.
</div>

<div class="note-box">
  <strong>Note:</strong> Force is a vector – direction matters.
</div>
```

---

11. NOW, PROCEED WITH THE GENERATION

Wait for me to provide the actual content (title, parts, chapters, etc.). Once I paste the content, generate the complete HTML file following all the above specifications.

```

---

**How to use this prompt:**

1. Copy the entire template above.
2. Replace the placeholders (e.g., `[Your Book Title]`, part/chapter structure) with your own details.
3. Paste the prompt into a conversation with an AI (like Claude or GPT-4).
4. Then, provide the actual content for each chapter in subsequent messages, and the AI will generate the final HTML.

This prompt is designed to be reusable for any non‑fiction book that requires clear formatting of formulas, definitions, and examples.

examples.
