# Organização, Montagem e Manutenção de Computadores

Esboço de apostila de Organização, Montagem e Manutenção de computadores.

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
python3 pdf/build_pdf.py                          # gera organizacao-e-montagem-livro.pdf e manutencao-de-computadores-livro.pdf
python3 pdf/build_pdf.py organizacao-e-montagem   # só um dos dois, se preferir
```
