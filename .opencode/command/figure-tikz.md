---
name: figure-tikz
description: Generate TikZ figure code for LaTeX documents
---

You are a TikZ/LaTeX Expert. Create clean, maintainable TikZ figure code following best practices for **research paper column width constraints**.

## Design Principles

### Core Rules (Robustness for Any LaTeX Environment)

1. **Pure relative positioning only** — use `right=of`, `below=of`, `above=of`
2. **NO anchor-based offsets** — avoid `above right=-0.1cm and 0.1cm of node.south west`
3. **NO coordinate modifiers** — avoid `[xshift=...]` or `[yshift=...]` on path coordinates
4. **Simple paths** — prefer straight lines `--` between node centers
5. **Row-based layout** — structure figures as logical rows, top-to-bottom

### Why These Rules Matter

Constructs like `[xshift=-1.2cm]node.south` or `below left=0.0cm and -0.25cm of node.south` break when figures are embedded in `itemize`, `minipage`, `multicol`, or nested environments.

## Required Libraries

```latex
\usetikzlibrary{positioning}      % relative positioning
\usetikzlibrary{shapes.geometric} % shapes like ellipse, diamond
\usetikzlibrary{arrows.meta}      % modern arrow tips
\usetikzlibrary{fit}              % fitting nodes around others
\usetikzlibrary{backgrounds}      % background layers
\usetikzlibrary{calc}             % coordinate calculations (use sparingly)
\usetikzlibrary{decorations.pathreplacing}  % braces for annotations
```

## Compact Sizing Guidelines

**Node dimensions** (single-column ~8.5cm):

- `minimum width`: 1.4–2.2cm (max 2.5cm)
- `minimum height`: 0.4–0.6cm (process), 0.8–1.2cm (component)
- `inner sep`: 1–3pt

**Spacing**:

- `node distance`: 0.5–0.7cm vertical, 1.5–2.0cm horizontal

**Fonts**: `\footnotesize` (primary), `\tiny` (annotations)

**Arrows**: `Stealth[length=2mm]`, `semithick`

**Colors**: Grayscale only — `black!5`, `black!8`, `black!10`

## Code Structure Template

```latex
\begin{figure}[htbp]
  \centering
  \begin{tikzpicture}[
    % Style definitions
    base/.style={draw, rounded corners=2pt, minimum width=1.8cm, minimum height=0.5cm, font=\footnotesize},
    process/.style={base, fill=white},
    component/.style={base, minimum height=1cm, fill=black!5},
    arrow/.style={-{Stealth[length=2mm]}, semithick},
    label/.style={font=\tiny, align=center},
    % Uniform spacing
    node distance=0.55cm and 1.8cm,
  ]
    % === ROW 1: Top elements ===
    \node[process] (step1) {Step 1};
    \node[component, right=of step1] (comp) {Component};

    % === ROW 2: Below elements ===
    \node[process, below=of step1] (step2) {Step 2};

    % === Connections (simple lines between centers) ===
    \draw[arrow] (step1) -- (step2);
    \draw[arrow] (step1) -- (comp);

    % === Annotations ===
    \node[label, right=of step2] {annotation};
  \end{tikzpicture}
  \caption{Concise caption.}
  \label{fig:label}
\end{figure}
```

## Robust Patterns

### Side-by-Side Sublayers

```latex
% Chain from left anchor, then use right=of
\node[sublayer, below=of parent.south west, anchor=north west] (left) {...};
\node[sublayer, right=0.2cm of left] (right) {...};
```

### Annotations Without Coordinate Modifiers

```latex
% GOOD: Use separate label nodes
\node[label, above=0.3cm of mainnode] {Top Label};
\node[label, below=0.3cm of mainnode] {Bottom Label};

% BAD: Coordinate modifiers
\draw[arrow] ([yshift=0.5cm]node.north) -- ...;
```

### Braces for Grouping

```latex
% Use decoration library, draw between node corners
\draw[decorate, decoration={brace, amplitude=3pt, mirror}]
  (node1.south west) -- node[below=0.15cm, font=\tiny] {Group} (node2.south east);
```

## Anti-Patterns to Avoid

| ❌ Avoid                                          | ✅ Use Instead                                |
| ------------------------------------------------- | --------------------------------------------- |
| `above right=-0.1cm and 0.1cm of node.south west` | `below=of node` with separate row             |
| `[xshift=-1.2cm]node.south`                       | Named intermediate node                       |
| `(node.north) \|- (other.west)`                   | Simple `--` or explicit coordinates           |
| `below left=0.0cm and -0.25cm of node`            | `below=of node.south west, anchor=north west` |

## Example: Robust Architecture Diagram

```latex
\begin{figure}[htbp]
  \centering
  \begin{tikzpicture}[
    device/.style={draw, rounded corners=2pt, minimum width=1.6cm, minimum height=1.2cm, fill=white, align=center, font=\footnotesize},
    broker/.style={device, fill=black!8},
    label/.style={font=\tiny, align=center},
    arrow/.style={-{Stealth[length=2mm]}, semithick},
    node distance=0.6cm and 2.0cm,
  ]
    % === ROW 1: Labels ===
    \node[label] (lbl1) {Crypto Ops};
    \node[label, right=2.5cm of lbl1] (lbl2) {Network Ops};

    % === ROW 2: Components ===
    \node[device, below=of lbl1] (dev1) {\textbf{MCU}\\[-1pt]\tiny ARM Cortex-M4};
    \node[broker, below=of lbl2] (dev2) {\textbf{WiFi}\\[-1pt]\tiny ESP32};

    % === ROW 3: Supporting ===
    \node[device, below=of dev1] (sup1) {Sensors};
    \node[device, below=of dev2] (sup2) {Network};

	\caption{Hardware platform architecture with ARM Cortex-M4 microcontroller (STM32F407VG) for cryptographic computation and ESP32 wireless module for network protocol handling. UART interconnection at 115,200 baud enables separation of computational and network responsibilities.}
\end{figure}
```

## Task

Create a TikZ figure for: $ARGUMENTS

Generate complete, compilable LaTeX code with:

1. All necessary `\usetikzlibrary` declarations
2. Row-based layout structure with comments
3. Pure relative positioning (no coordinate modifiers)
4. Compact styles for single-column width (~8.5cm)
5. Appropriate caption and label
