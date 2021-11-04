if !exists('g:loaded_cmp')
    finish
endif

set completeopt=menu,menuone,noselect

lua <<EOF
    local cmp = require'cmp'
    local luasnip = require'luasnip'

    cmp.setup({
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },
        mapping = {
            ['<C-p>'] = cmp.mapping.select_prev_item(),
            ['<C-n>'] = cmp.mapping.select_next_item(),
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.close(),
            ['<CR>'] = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Replace,
                select = true,
            }),
            ['<Tab>'] = function(fallback)
                if vim.fn.pumvisible() == 1 then
                    vim.fn.feedkeys(
                        vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n'
                    )
                elseif luasnip.expand_or_jumpable() then
                    vim.fn.feedkeys(
                        vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), ''
                    )
                else
                    fallback()
                end
            end,
            ['<S-Tab>'] = function(fallback)
                if vim.fn.pumvisible() == 1 then
                    vim.fn.feedkeys(
                        vim.api.nvim_replace_termcodes('<C-p>', true, true, true), 'n'
                    )
                elseif luasnip.jumpable(-1) then
                    vim.fn.feedkeys(
                        vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), ''
                    )
                else
                    fallback()
                end
            end,
        },
        sources = {
            { name = 'buffer' },
            { name = 'luasnip' },
        }
    })
EOF
