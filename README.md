# Organização, Montagem e Manutenção de Computadores

Livro didático em duas partes para o curso técnico de informática do IFRN:

- **Livro 1 — Organização e Montagem de Computadores** (5 capítulos)
- **Livro 2 — Manutenção de Computadores** (4 capítulos, continuação direta do curso anterior)

Site publicado via GitHub Pages (build automático a cada push em `main`, ver `.github/workflows/publish.yml`). PDFs de cada livro ficam disponíveis para download a partir do site.

## Estrutura

- `docs/` — conteúdo do site (mkdocs-material).
- `capitulos/` — fonte dos capítulos usada pelo pipeline de PDF (`pandoc` → `xelatex`), independente do pipeline do site.
- `pdf/` — template LaTeX e script de build dos PDFs.
- `mkdocs.yml` — configuração do site.

## Rodar localmente

```bash
python3 -m venv .venv && source .venv/bin/activate
pip install -r requirements.txt
mkdocs serve
```

Build de PDF (requer `pandoc` e `xelatex`):

```bash
python3 pdf/build_pdf.py            # gera info2m-livro.pdf e info3m-livro.pdf
python3 pdf/build_pdf.py info2m     # só um dos dois, se preferir
```
