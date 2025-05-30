-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
-- Format on save and linters
return {
  -- {
  --   'hedyhli/outline.nvim',
  --   config = function()
  --     -- Key mapping to toggle outline
  --     vim.keymap.set('n', '<leader>o', '<cmd>Outline<CR>', { desc = 'Toggle Outline' })
  --
  --     require('outline').setup {
  --       -- Basic configuration
  --       outline_window = {
  --         position = 'right',
  --         width = 25,
  --         relative_width = true,
  --         auto_close = false,
  --       },
  --     }
  --   end,
  --   -- Optional: lazy-load the plugin with these triggers
  --   -- lazy = true,
  --   -- cmd = { "Outline", "OutlineOpen" },
  -- },
  --
  --
  -- Add undotree here
  {
    'chentoast/marks.nvim',
    config = function()
      require('marks').setup {
        -- whether to map keybinds or not. default true
        default_mappings = true,
        -- which builtin marks to show. default {}
        builtin_marks = { '.', '<', '>', '^' },
        -- whether movements cycle back to the beginning/end of buffer. default true
        cyclic = true,
        -- whether the shada file is updated after modifying uppercase marks. default false
        force_write_shada = false,
        -- how often (in ms) to redraw signs. default 150
        refresh_interval = 250,
        -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase marks
        sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
        -- disables mark tracking for specific filetypes. default {}
        excluded_filetypes = {},
        -- disables mark tracking for specific buftypes. default {}
        excluded_buftypes = {},
        -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
        -- sign/virttext. Bookmarks can be used to group together positions and quickly move
        -- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
        -- default virt_text is "".
        bookmark_0 = {
          sign = '⚑',
          virt_text = 'hello world',
          -- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
          -- defaults to false.
          annotate = false,
        },
        mappings = {},
      }

      -- Key mappings to show marks
      vim.keymap.set('n', '<leader>ml', '<cmd>MarksListBuf<cr>', { desc = 'List marks in buffer' })
      vim.keymap.set('n', '<leader>mL', '<cmd>MarksListGlobal<cr>', { desc = 'List all marks' })
      vim.keymap.set('n', '<leader>mt', '<cmd>MarksToggleSigns<cr>', { desc = 'Toggle mark signs' })
    end,
  },
  {
    'utilyre/barbecue.nvim',
    dependencies = {
      'SmiteshP/nvim-navic',
      'nvim-tree/nvim-web-devicons', -- Optional for icons
    },
    config = function()
      require('barbecue').setup {
        theme = 'auto',
        include_buftypes = { '' },
        exclude_filetypes = { 'gitcommit', 'toggleterm' },
        show_modified = true,
      }
    end,
  },
  {
    'mbbill/undotree',
    config = function()
      -- Key mapping to toggle undotree
      vim.keymap.set('n', '<leader>u', '<cmd>UndotreeToggle<CR>', { desc = 'Toggle Undotree' })
    end,
    -- Optional: lazy-load the plugin
    -- lazy = true,
    -- cmd = { "UndotreeToggle" },
  },
  {
    'stevearc/aerial.nvim',
    config = function()
      -- Key mapping to toggle aerial outline
      vim.keymap.set('n', '<leader>o', '<cmd>AerialToggle<CR>', { desc = 'Toggle Aerial Outline' })

      require('aerial').setup {
        -- Position the aerial window on the right side
        layout = {
          default_direction = 'right',
          placement = 'edge',
        },
        -- Set width similar to your outline.nvim config
        width = 25,
        -- Relative width like your outline config
        relative_width = true,
        -- Additional recommended settings
        close_automatic_events = {}, -- Similar to your auto_close = false
        manage_folds = false,
        link_folds_to_tree = false,
        link_tree_to_folds = false,
        -- Show icons for different symbol types
        icons = {
          show = true,
          default_icon = '󰎤',
        },
      }
    end,
    -- Optional: lazy-load similar to your outline config
    -- lazy = true,
    -- cmd = { "AerialToggle", "AerialOpen" },
  },
  {
    'christoomey/vim-tmux-navigator',
    cmd = {
      'TmuxNavigateLeft',
      'TmuxNavigateDown',
      'TmuxNavigateUp',
      'TmuxNavigateRight',
      'TmuxNavigatePrevious',
      'TmuxNavigatorProcessList',
    },
    keys = {
      { '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>' },
      { '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>' },
      { '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>' },
      { '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>' },
      { '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>' },
    },
  },
  {
    'AckslD/nvim-neoclip.lua',
    dependencies = {
      -- you'll need at least one of these
      -- {'nvim-telescope/telescope.nvim'},
      -- {'ibhagwan/fzf-lua'},
    },
    config = function()
      require('neoclip').setup()
    end,
  },
  {
    'b0o/blender.nvim',
    config = function()
      require('blender').setup()
    end,
    dependencies = {
      'MunifTanjim/nui.nvim',
      'grapp-dev/nui-components.nvim',
      'mfussenegger/nvim-dap', -- Optional, for debugging with DAP
      'LiadOz/nvim-dap-repl-highlights', -- Optional, for syntax highlighting in the DAP REPL
    },
  },
  {
    'nvimtools/none-ls.nvim',
    dependencies = {
      'nvimtools/none-ls-extras.nvim',
      'jayp0521/mason-null-ls.nvim', -- ensure dependencies are installed
    },
    {
      'ellisonleao/gruvbox.nvim',
      priority = 1000, -- Make sure it loads early
      config = true,
    },
    config = function()
      local null_ls = require 'null-ls'
      local formatting = null_ls.builtins.formatting -- to setup formatters
      local diagnostics = null_ls.builtins.diagnostics -- to setup linters

      -- list of formatters & linters for mason to install
      require('mason-null-ls').setup {
        ensure_installed = {
          'checkmake',
          'prettier', -- ts/js formatter
          'stylua', -- lua formatter
          'eslint_d', -- ts/js linter
          'shfmt',
          'ruff',
        },
        -- auto-install configured formatters & linters (with null-ls)
        automatic_installation = true,
      }

      local sources = {
        diagnostics.checkmake,
        formatting.prettier.with { filetypes = { 'html', 'json', 'yaml', 'markdown' } },
        formatting.stylua,
        formatting.shfmt.with { args = { '-i', '4' } },
        formatting.terraform_fmt,
        require('none-ls.formatting.ruff').with { extra_args = { '--extend-select', 'I' } },
        require 'none-ls.formatting.ruff_format',
      }

      local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
      null_ls.setup {
        -- debug = true, -- Enable debug mode. Inspect logs with :NullLsLog.
        sources = sources,
        -- you can reuse a shared lspconfig on_attach callback here
        on_attach = function(client, bufnr)
          if client.supports_method 'textDocument/formatting' then
            vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
            vim.api.nvim_create_autocmd('BufWritePre', {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format { async = false }
              end,
            })
          end
        end,
      }
    end,
  },
  {
    -- HARPUUUUN
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require 'harpoon'

      -- Initialize Harpoon
      harpoon:setup()
      harpoon:setup {}

      -- basic telescope configuration
      local conf = require('telescope.config').values
      local function toggle_telescope(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
        end

        require('telescope.pickers')
          .new({}, {
            prompt_title = 'Harpoon',
            finder = require('telescope.finders').new_table {
              results = file_paths,
            },
            previewer = conf.file_previewer {},
            sorter = conf.generic_sorter {},
          })
          :find()
      end

      vim.keymap.set('n', '<F3>', function()
        toggle_telescope(harpoon:list())
      end, { desc = 'Open harpoon window' })
      -- Original Harpoon keybindings
      vim.keymap.set('n', '<leader>a', function()
        harpoon:list():append()
      end)
      vim.keymap.set('n', '<leader>e', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end)
      vim.keymap.set('n', '<leader>h', function()
        harpoon:list():select(1)
      end)
      vim.keymap.set('n', '<leader>j', function()
        harpoon:list():select(2)
      end)
      vim.keymap.set('n', '<leader>k', function()
        harpoon:list():select(3)
      end)
      vim.keymap.set('n', '<leader>l', function()
        harpoon:list():select(4)
      end)
      -- Register a terminal list alongside the default file list
      -- Terminal switching with Harpoon 2
      local harpoon = require 'harpoon'

      -- Initialize harpoon (if you haven't already)
      harpoon:setup {
        -- Define lists during setup
        lists = {
          {
            name = 'terminals',
            items = {}, -- Start with empty list
          },
        },
      }

      -- Get reference to the terminals list
      local terminals = harpoon:list 'terminals'

      -- Function to create a terminal buffer or switch to existing one
      local function create_or_switch_terminal(term_id)
        -- Check if the terminal item exists at that position
        local term_item = terminals:get(term_id)
        local term_buf = term_item and term_item.value

        -- Check if terminal exists and is valid
        if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
          -- Switch to existing terminal
          local win_ids = vim.fn.win_findbuf(term_buf)
          if #win_ids > 0 then
            -- Terminal is visible, switch to it
            vim.api.nvim_set_current_win(win_ids[1])
          else
            -- Terminal exists but isn't visible, open it in a split
            vim.cmd 'split'
            vim.api.nvim_win_set_buf(0, term_buf)
          end
        else
          -- Create new terminal
          vim.cmd 'split'
          vim.cmd 'terminal'

          -- Store the terminal buffer ID in Harpoon
          local term_buf_id = vim.api.nvim_get_current_buf()

          -- If there's already an item at this position, update it
          if term_item then
            terminals:remove(term_id)
          end

          -- Ensure we have enough items in the list
          while terminals:length() < term_id do
            terminals:append { value = nil }
          end

          -- Add the terminal at the specified position
          terminals:append { value = term_buf_id }
        end

        -- Enter insert mode to start typing in terminal
        vim.cmd 'startinsert'
      end

      -- Key mappings for terminal switching
      vim.keymap.set('n', '<leader>t1', function()
        create_or_switch_terminal(1)
      end, { desc = 'Switch to terminal 1' })
      vim.keymap.set('n', '<leader>t2', function()
        create_or_switch_terminal(2)
      end, { desc = 'Switch to terminal 2' })
      vim.keymap.set('n', '<leader>t3', function()
        create_or_switch_terminal(3)
      end, { desc = 'Switch to terminal 3' })

      -- Toggle terminal list UI (similar to file list)
      vim.keymap.set('n', '<leader>tt', function()
        harpoon.ui:toggle_quick_menu(terminals)
      end, { desc = 'Toggle terminal list' })

      -- Exit terminal mode with Escape
      vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
    end,
  },
}
