#!/usr/bin/env python3
"""Builda o PDF do livro via pandoc -> xelatex.

Lê de capitulos/ (não de docs/) — o pipeline de PDF é independente do
pipeline do site: docs/ tem os placeholders [IMAGEM: ...] já convertidos
para admonition do mkdocs-material, capitulos/ mantém o texto original,
que é o que o filtro Lua deste pipeline (filtro-imagem-pendente.lua)
espera. capitulos/ é sincronizado a partir de ../livro por
scripts/sync_chapters.py (só no repositório privado) — deliberadamente não
lê essa pasta diretamente, para que este script funcione sem alterações
quando publicacao/ vira a raiz de um repositório público separado (que não
tem acesso aos *_material_para_o_professor.md do repositório privado).

Uso: python3 pdf/build_pdf.py
"""
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent  # publicacao/
CAPITULOS = ROOT / "capitulos"
PDF_DIR = ROOT / "pdf"
LIVRO = "livro"
OUT_NAME = "livro-organizacao-e-manutencao-de-computadores.pdf"


def is_chapter_file(path: Path) -> bool:
    name = path.name
    if not name.endswith(".md"):
        return False
    if "material_para_o_professor" in name:
        return False
    if name.startswith("_"):
        return False
    return True


def build() -> None:
    src_dir = CAPITULOS / LIVRO
    chapters = sorted(p for p in src_dir.glob("*.md") if is_chapter_file(p))
    if not chapters:
        print(f"AVISO: nenhum capítulo encontrado em {src_dir}", file=sys.stderr)
        return

    out_path = ROOT / OUT_NAME
    cmd = [
        "pandoc",
        *[str(c) for c in chapters],
        f"--metadata-file={PDF_DIR / (LIVRO + '.yaml')}",
        f"--template={PDF_DIR / 'template.tex'}",
        f"--lua-filter={PDF_DIR / 'filtro-imagem-pendente.lua'}",
        f"--resource-path={src_dir}",
        "--top-level-division=chapter",
        "--pdf-engine=xelatex",
        "-o", str(out_path),
    ]
    print(f"Compilando {LIVRO} ({len(chapters)} capítulos) -> {out_path}")
    # cwd=PDF_DIR para que \input{preambulo-livro.tex} (relativo) resolva corretamente
    subprocess.run(cmd, check=True, cwd=PDF_DIR)
    print(f"OK: {out_path}")


def main() -> None:
    build()


if __name__ == "__main__":
    main()
