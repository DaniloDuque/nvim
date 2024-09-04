return {
  {
    "AstroNvim/astroui",
    ---@type AstroUIOpts
    opts = {
      icons = {
        VimIcon = "",
        ScrollText = "",
        GitBranch = "",
        GitAdd = "",
        GitChange = "",
        GitDelete = "",
      },
      status = {
        separators = {
          left = { "", "" },
          right = { " ", "" },
          tab = { "", "" },
        },
        colors = function(hl)
          local get_hlgroup = require("astroui").get_hlgroup
          local comment_fg = get_hlgroup("Comment").fg
          hl.git_branch_fg = comment_fg
          hl.git_added = comment_fg
          hl.git_changed = comment_fg
          hl.git_removed = comment_fg
          hl.blank_bg = get_hlgroup("Folded").fg
          hl.file_info_bg = get_hlgroup("Visual").bg
          hl.nav_icon_bg = get_hlgroup("String").fg
          hl.nav_fg = hl.nav_icon_bg
          hl.folder_icon_bg = get_hlgroup("Error").fg
          return hl
        end,
        attributes = {
          mode = { bold = true },
        },
        icon_highlights = {
          file_icon = {
            statusline = false,
          },
        },
      },
    },
  },
  {
    "rebelot/heirline.nvim",
    opts = function(_, opts)
      local status = require("astroui.status")
      local get_hlgroup = require("astroui").get_hlgroup
      -- Obtén el color de fondo del grupo de highlights 'Normal'
      local normal_bg = get_hlgroup("Normal").bg

      opts.statusline = {
        -- Aplica el color de fondo del editor (normal_bg) a toda la statusline
        hl = { fg = normal_bg, bg = normal_bg },
        -- cada elemento siguiente es un componente en el módulo astroui.status

        -- Componente del modo de Vim
        status.component.mode({
          mode_text = {
            icon = { kind = "VimIcon", padding = { right = 1, left = 1 } },
          },
          surround = {
            separator = "left",
            color = function()
              -- Devuelve una tabla en lugar de un valor único
              return { main = normal_bg, right = normal_bg }
            end,
          },
        }),
        -- Espacio vacío
        status.component.builder({
          { provider = "" },
          surround = {
            separator = "left",
            color = { main = normal_bg, right = normal_bg },
          },
        }),
        -- Información del archivo abierto
        status.component.file_info({
          filename = { fallback = "Empty" },
          filetype = false,
          file_read_only = false,
          padding = { right = 1 },
          surround = { separator = "left", color = { bg = normal_bg } },
        }),
        -- Componente de la rama de Git
        status.component.git_branch({
          git_branch = { padding = { left = 1 } },
          surround = { separator = "none", color = { bg = normal_bg } },
        }),
        -- Componente para las diferencias de Git
        status.component.git_diff({
          padding = { left = 1 },
          surround = { separator = "none", color = { bg = normal_bg } },
        }),
        -- Llena el resto de la statusline
        status.component.fill(),
        -- Componente para el estado del LSP
        status.component.lsp({
          lsp_client_names = false,
          surround = { separator = "none", color = { bg = normal_bg } },
        }),
        -- Llena el resto de la statusline
        status.component.fill(),
        -- Componente para diagnósticos
        status.component.diagnostics({ surround = { separator = "right", color = { bg = normal_bg } } }),
        -- Componente del progreso del LSP
        status.component.lsp({
          lsp_progress = false,
          surround = { separator = "right", color = { bg = normal_bg } },
        }),
        -- Sección personalizada con iconos
        {
          status.component.builder({
            { provider = require("astroui").get_icon("FolderClosed") },
            padding = { right = 1 },
            hl = { fg = normal_bg },
            surround = { separator = "right", color = { bg = normal_bg } },
          }),
          -- Información del archivo mostrando el directorio actual
          status.component.file_info({
            filename = {
              fname = function(nr)
                return vim.fn.getcwd(nr)
              end,
              padding = { left = 1 },
            },
            filetype = false,
            file_icon = false,
            file_modified = false,
            file_read_only = false,
            surround = { separator = "none", color = { bg = normal_bg } },
          }),
        },
        -- Sección de navegación
        {
          status.component.builder({
            { provider = require("astroui").get_icon("ScrollText") },
            padding = { right = 1 },
            hl = { fg = normal_bg },
            surround = {
              separator = "right",
              color = { main = normal_bg, left = normal_bg },
            },
          }),
          status.component.nav({
            percentage = { padding = { right = 1 } },
            ruler = false,
            scrollbar = false,
            surround = { separator = "none", color = { bg = normal_bg } },
          }),
        },
      }
    end,
  },
}

