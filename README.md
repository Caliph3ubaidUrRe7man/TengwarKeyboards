# TengwarKeyboards

A curated collection of Tengwar fonts and keyboard layouts derived from the FreeTengwar project (freetengwar.sourceforge.net). This repository packages the official fonts and the Tengwar QWERTY keyboard and adds a Dvorak-based layout used by the maintainer.

**Repository purpose**: provide packaged Tengwar fonts and keyboard layouts, include a Dvorak-based layout variation, document compatibility constraints (notably Graphite font limitations), and preserve original licensing and source references.

**Quick summary**
- Source: Based on the FreeTengwar project (freetengwar.sourceforge.net). Documentation on that site is largely outdated (over 15 years old) — this repo preserves the original resources and adds a Dvorak-based keyboard.
- Main addition: a Dvorak-based Tengwar keyboard layout (see `DVorakBased`).
- Important compatibility note: the `Tengwar Telcontar` font is a Graphite font. Graphite fonts only work in applications that support the Graphite engine (LibreOffice / OpenOffice are confirmed to work). Microsoft Office, Google Docs, and many other proprietary systems do not support Graphite; using these fonts in formats such as `.docx` or Google Docs will likely break rendering. For documents using these fonts prefer open formats such as ODF.

## Repository layout
- `DVorakBased/` — Dvorak-based Tengwar keyboard layout and supporting files. This is the primary addition in this repository: a layout that maps Tengwar input to a Dvorak physical key layout.
- `QWERTYBased/` — Original Tengwar QWERTY keyboard resources and an `install.sh` script. Includes `ucteng` and other utilities used by the FreeTengwar project.
- `MonospaceTTF/` — Font sources and tooling for the monospace Tengwar fonts (FreeMonoTengwar.* and `makefonts.py`). Includes licensing files (`GPL.txt`) and `FontLog.txt` describing the build or changes.
- `TelcontarTTF/` — Contains the Tengwar Telcontar font files and textual README/COPYING notes. Note: this is a Graphite font (see compatibility notes above).

## Installation (fonts)
1. Copy the font files from `MonospaceTTF/` and `TelcontarTTF/` into a system or user font directory (example user font dir: `~/.local/share/fonts/` or `~/.fonts/` on some systems).
2. Update the font cache:

```bash
fc-cache -f -v
```

3. Test the fonts in LibreOffice / OpenOffice (recommended) — these suites include Graphite support and will render Telcontar correctly.

## Installation (keyboard layouts)
- For the QWERTY layout: inspect and run `QWERTYBased/install.sh` which sets up the `ucteng` keyboard mapping. Review the script before running.
- For the Dvorak layout: see `DVorakBased/README` or `tengdvorak` inside that folder for instructions specific to the Dvorak keyboard files. You may need to install user keymap files or use the provided helper scripts.

## Compatibility and document recommendations
- Telcontar is a Graphite font: only applications that support Graphite will render it correctly (LibreOffice, OpenOffice). Many common applications (Microsoft Word, Google Docs, and some web apps) do not support Graphite; in those environments the font features will not work and text can appear broken.
- When authoring documents with these fonts, use open formats (ODF — `.odt`) and open-source office suites to ensure correct rendering and portability.

## About the original documentation
- The FreeTengwar web documentation is over 15 years old and may be incomplete or out of date relative to modern font engines and office suites. This repository keeps the original resources but adds compatibility notes and a Dvorak layout to reflect more recent needs.

## Licensing and credits
- These fonts and keyboard files were originally packaged by the FreeTengwar project. Please consult the license files included in the subfolders:
  - `MonospaceTTF/GPL.txt`
  - `QWERTYBased/COPYING` 
  - `TelcontarTTF/COPYING.txt`
- Respect the original licenses when redistributing or modifying the fonts or keyboard layouts.

## Troubleshooting
- If fonts do not appear after installation, run `fc-cache -f -v` and restart your application.
- If Tengwar characters render incorrectly in your documents, verify the application supports Graphite and that the document format preserves font features (prefer ODF).

## Contributing
- Pull requests are welcome. Please include a short description of changes, any build steps used for fonts, and relevant license information.
- If you add new layouts or fonts, include a short README in the corresponding folder explaining usage and any special compatibility notes.

## Contact & references
- Original project: FreeTengwar (freetengwar.sourceforge.net)
- This repository preserves and repackages those resources and provides an additional Dvorak-based keyboard layout.

---
If you want, I can also:
- run a quick font-install test on this system and verify the Telcontar rendering in LibreOffice (if LibreOffice is available), or
- add a short `DVorakBased/README` explaining the Dvorak keyboard installation steps in detail.
