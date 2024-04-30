vim.cmd [[  
  colorscheme iceberg
]]
--  "hi StatusLine term=NONE cterm=NONE ctermfg=238 ctermbg=234 guifg=234 guibg=234
--  hi StatusLine cterm=NONE ctermfg=251 ctermbg=234 guifg=234 guibg=234
--  hi StatusLineNC ctermfg=234 ctermbg=241  guifg=234 guibg=234
--  hi StatusLineTerm term=NONE cterm=NONE ctermfg=234 ctermbg=234 guifg=234 guibg=234
--  hi StatusLineTermNC term=NONE cterm=NONE ctermfg=234 ctermbg=234 guifg=234 guibg=234
--  " tab
--  hi TabLineFill ctermbg=234 ctermfg=234 guibg=NONE guifg=None
--  hi TabLineSel ctermbg=234 ctermfg=251 guibg=NONE guifg=None
--  hi TabLine ctermbg=234 ctermfg=239 guibg=234 guifg=239
--  hi SignColumn ctermbg=234 ctermfg=239 guibg=NONE guifg=None
--
--  hi VertSplit cterm=NONE ctermfg=234 ctermbg=234 guibg=234 guifg=234
--  hi ModeMsg cterm=NONE ctermfg=234 ctermbg=234 guibg=234 guifg=234

local M = {}
local fn = vim.fn

function set(hls)
    for group, value in pairs(hls) do
        vim.api.nvim_set_hl(0, group, value)
    end
end

function link(links)
    for from, to in pairs(links) do
        vim.api.nvim_set_hl(0, from, {
            link = to,
        })
    end
end

link { 
  TabLineSel = 'Normal',
  StatusLine = 'Normal',
}
set {
    TabLine = { fg = '#707070', bg = '#202020' },
    TabLineSel = { fg = '#cccccc', bg = '#202020' },
    TabLineFill = { fg = 'NONE', bg = '#202020' },

    StatusLine = { fg = '#cccccc', bg = '#202020' },
    StatusLineNC = { fg = '#505050', bg = '#202020' },
    StatusLineFill = { fg = '#707070', bg = '#202020' },

    SignColumn = { fg = '#707070', bg = '#202020' },
}

