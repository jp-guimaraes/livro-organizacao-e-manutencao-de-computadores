-- Remove numeração manual dos títulos ("Capítulo 1 — Fundamentos..." ->
-- "Fundamentos...", "1.1 Definição de..." -> "Definição de..."), porque o
-- LaTeX (scrbook) já numera \chapter/\section/\subsection automaticamente —
-- sem isso o PDF mostra número duplicado ("1 Capítulo 1 —...", "1.1 1.1...").
-- O site (mkdocs) não sofre disso, pois não numera cabeçalhos sozinho.
function Header(el)
  local text = pandoc.utils.stringify(el)
  local novo = text

  if el.level == 1 then
    -- Classes de caracteres Lua operam byte a byte: "í" e "—" são multibyte
    -- em UTF-8, então usamos alternativas literais em vez de [íi]/[—%-:].
    local resto = text:match("^Capítulo%s+%d+%s*—%s*(.+)$")
      or text:match("^Capitulo%s+%d+%s*—%s*(.+)$")
      or text:match("^Capítulo%s+%d+%s*%-%s*(.+)$")
      or text:match("^Capítulo%s+%d+%s*:%s*(.+)$")
    if resto then
      novo = resto
    end
  else
    local resto = text:match("^%d+%.[%d%.]*%s+(.+)$")
    if resto then
      novo = resto
    end
  end

  if novo ~= text then
    el.content = { pandoc.Str(novo) }
  end
  return el
end

-- Converte parágrafos "[IMAGEM: descrição]" em uma caixa de destaque no PDF
-- (ambiente `figurapendente`, definido em preambulo-livro.tex).
function Para(el)
  local text = pandoc.utils.stringify(el)
  local descricao = text:match("^%[IMAGEM:%s*(.-)%s*%]$")
  if descricao then
    return {
      pandoc.RawBlock("latex", "\\begin{figurapendente}"),
      pandoc.Para({ pandoc.Str(descricao) }),
      pandoc.RawBlock("latex", "\\end{figurapendente}"),
    }
  end
  return el
end

-- Referência a figura no texto: "@fig:id" (que o pandoc lê como citação)
-- vira "Figura~\\ref{fig:id}". O \\label{fig:id} é emitido pelo próprio pandoc
-- para ![legenda](img){#fig:id alt="..."}; o LaTeX numera por capítulo (5.3).
-- O site faz a mesma conversão em scripts/sync_chapters.py.
function Cite(el)
  if #el.citations == 1 then
    local id = el.citations[1].id
    if id:match("^fig:") then
      return { pandoc.Str("Figura"), pandoc.RawInline("latex", "~\\ref{" .. id .. "}") }
    end
  end
  return nil
end

-- Figuras numeradas ocupam a largura do texto, limitadas a 75% da altura da
-- página (para as altas, como o layout da MBR); keepaspectratio no preâmbulo.
function Figure(fig)
  return pandoc.walk_block(fig, {
    Image = function(img)
      img.attributes.width = "100%"
      img.attributes.height = "75%"
      return img
    end
  })
end
