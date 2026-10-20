-- Sirius Blog note filter.
--
-- Notes stay plain Markdown that follows CLAUDE.md conventions. This filter
-- turns those conventions into styled markup at render time:
--   * `# 中文标题 (English Title)`   -> page title + subtitle (dark banner)
--   * `## N. 中文 (English)`          -> big section number + English subline
--   * `**Definition.** ...`           -> labelled block, grouped with the
--                                        display math / lists that follow it,
--                                        until the next label or heading
--   * the `标签约定：...` legend line -> coloured tag chips
--   * pages with formulas            -> preload hints for MathJax's font

local stringify = pandoc.utils.stringify

local LABELS = {
  Definition = "definition",
  Theory = "theory",
  Inference = "inference",
  Result = "result",
}

local function is_plain_text(inlines)
  for _, el in ipairs(inlines) do
    if el.t ~= "Str" and el.t ~= "Space" and el.t ~= "SoftBreak" then
      return false
    end
  end
  return true
end

-- "中文 (English)" -> "中文", "English"
local function split_bilingual(s)
  local cn, en = s:match("^(.-)%s*%(([^()]+)%)%s*$")
  if cn and cn ~= "" then
    return cn, en
  end
  return s, nil
end

local function chip(name)
  return pandoc.Span({ pandoc.Str(name) }, pandoc.Attr("", { "tag-chip", "tag-" .. LABELS[name] }))
end

local function label_of(block)
  if block.t ~= "Para" then
    return nil
  end
  local first = block.content[1]
  if not first or first.t ~= "Strong" then
    return nil
  end
  local name = stringify(first):match("^(%a+)%.$")
  if name and LABELS[name] then
    return name
  end
  return nil
end

local function build_tag_block(name, blocks)
  local first = blocks[1]
  local inlines = first.content
  inlines:remove(1)
  while inlines[1] and (inlines[1].t == "Space" or inlines[1].t == "SoftBreak") do
    inlines:remove(1)
  end
  if #inlines == 0 then
    table.remove(blocks, 1)
  end
  local label = pandoc.Div({ pandoc.Plain({ chip(name) }) }, pandoc.Attr("", { "tag-label" }))
  local body = pandoc.Div(blocks, pandoc.Attr("", { "tag-body" }))
  return pandoc.Div({ label, body }, pandoc.Attr("", { "tag-block", "tag-" .. LABELS[name] }))
end

local function tag_legend(block)
  if block.t ~= "Para" or not stringify(block):find("^标签约定") then
    return nil
  end
  local content = block.content:walk({
    Code = function(c)
      if LABELS[c.text] then
        return chip(c.text)
      end
    end,
  })
  return pandoc.Div({ pandoc.Para(content) }, pandoc.Attr("", { "tag-legend" }))
end

-- Split a trailing "(English Title)" off a list of inlines. The Chinese part
-- may contain code or math; the English part must be plain words.
local function split_trailing_english(inlines)
  local last = inlines[#inlines]
  if not (last and last.t == "Str" and last.text:match("%)$")) then
    return inlines, nil
  end
  for i = #inlines, 1, -1 do
    local el = inlines[i]
    if el.t ~= "Str" and el.t ~= "Space" then
      break
    end
    local p = el.t == "Str" and el.text:find("(", 1, true)
    if p then
      local head = pandoc.List()
      for j = 1, i - 1 do
        head:insert(inlines[j])
      end
      if p > 1 then
        head:insert(pandoc.Str(el.text:sub(1, p - 1)))
      end
      while #head > 0 and head[#head].t == "Space" do
        head:remove(#head)
      end
      local tail = pandoc.List({ pandoc.Str(el.text:sub(p)) })
      for j = i + 1, #inlines do
        tail:insert(inlines[j])
      end
      local en = stringify(tail):match("^%((.*)%)$")
      if en and #head > 0 then
        return head, en
      end
      break
    end
  end
  return inlines, nil
end

local function numbered_header(h)
  if h.level ~= 2 then
    return h
  end
  local first, second = h.content[1], h.content[2]
  local num = first and first.t == "Str" and first.text:match("^(%d+)%.$")
  if not num or not (second and second.t == "Space") then
    return h
  end
  local rest = pandoc.List()
  for i = 3, #h.content do
    rest:insert(h.content[i])
  end
  local cn, en = split_trailing_english(rest)
  local title = pandoc.List(cn)
  if en then
    title:insert(pandoc.Span({ pandoc.Str(en) }, pandoc.Attr("", { "sec-en" })))
  end
  h.content = {
    pandoc.Span({ pandoc.Str(num) }, pandoc.Attr("", { "sec-num" })),
    pandoc.Span(title, pandoc.Attr("", { "sec-title" })),
  }
  h.classes:insert("sec-numbered")
  return h
end

-- On pages with formulas, start fetching the STIX Two font data while the
-- MathJax script itself downloads, instead of after it runs. Keep the version
-- in step with the MathJax url in _quarto.yml (MathJax 4.1 loads the font
-- package at its own version from jsDelivr).
local MATHJAX_HINTS = [[
<link rel="preconnect" href="https://cdn.jsdelivr.net" crossorigin>
<link rel="preload" as="script" href="https://cdn.jsdelivr.net/npm/@mathjax/mathjax-stix2-font@4.1.3/chtml.js">
<link rel="preload" as="script" href="https://cdn.jsdelivr.net/npm/mathjax@4.1.3/a11y/assistive-mml.js">
<link rel="preload" as="font" type="font/woff2" crossorigin href="https://cdn.jsdelivr.net/npm/@mathjax/mathjax-stix2-font@4.1.3/chtml/woff2/mjx-stx-zero.woff2">
<link rel="preload" as="font" type="font/woff2" crossorigin href="https://cdn.jsdelivr.net/npm/@mathjax/mathjax-stix2-font@4.1.3/chtml/woff2/mjx-stx-n.woff2">
<link rel="preload" as="font" type="font/woff2" crossorigin href="https://cdn.jsdelivr.net/npm/@mathjax/mathjax-stix2-font@4.1.3/chtml/woff2/mjx-stx-lo.woff2">
<link rel="preload" as="font" type="font/woff2" crossorigin href="https://cdn.jsdelivr.net/npm/@mathjax/mathjax-stix2-font@4.1.3/chtml/woff2/mjx-stx-s6.woff2">
]]

local function add_mathjax_hints(doc)
  local has_math = false
  doc:walk({
    Math = function()
      has_math = true
    end,
  })
  if not has_math then
    return
  end
  local hints = pandoc.Blocks({ pandoc.RawBlock("html", MATHJAX_HINTS) })
  local includes = doc.meta["header-includes"]
  if includes == nil then
    doc.meta["header-includes"] = pandoc.List({ hints })
  elseif pandoc.utils.type(includes) == "List" then
    includes:insert(hints)
  else
    doc.meta["header-includes"] = pandoc.List({ includes, hints })
  end
end

local function promote_title(doc)
  if doc.meta.title then
    return
  end
  local first = doc.blocks[1]
  if not (first and first.t == "Header" and first.level == 1) then
    return
  end
  doc.meta.pagetitle = stringify(first.content)
  if is_plain_text(first.content) then
    local cn, en = split_bilingual(stringify(first.content))
    doc.meta.title = pandoc.MetaInlines({ pandoc.Str(cn) })
    if en then
      doc.meta.subtitle = pandoc.MetaInlines({ pandoc.Str(en) })
    end
  else
    doc.meta.title = pandoc.MetaInlines(first.content)
  end
  doc.blocks:remove(1)
end

function Pandoc(doc)
  promote_title(doc)
  add_mathjax_hints(doc)

  local out = pandoc.List()
  local current, group = nil, nil
  local function flush()
    if current then
      out:insert(build_tag_block(current, group))
    end
    current, group = nil, nil
  end

  for _, block in ipairs(doc.blocks) do
    local name = label_of(block)
    if name then
      flush()
      current, group = name, { block }
    elseif block.t == "Header" then
      flush()
      out:insert(numbered_header(block))
    elseif block.t == "HorizontalRule" then
      flush()
      out:insert(block)
    elseif current then
      table.insert(group, block)
    else
      out:insert(tag_legend(block) or block)
    end
  end
  flush()

  doc.blocks = out
  return doc
end
