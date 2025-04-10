local utils = require('user.utils')
local lines_from = utils.lines_from

local M = {}

-- jedi LSP functions
local function is_jedi_interpreter_correct(lsp_client, pyexe)
    local needs_new = true
    if lsp_client.config["init_options"] ~= nil then
        if lsp_client.config.init_options["workspace"] ~= nil then
            if lsp_client.config.init_options.workspace.environmentPath == pyexe then
                needs_new = false
            end
        end
    end
    return needs_new
end

local function create_interpreter_options_for_jedi(pyexe)
    local init_options = {
        workspace = {
            environmentPath = pyexe
        }
    }
    return init_options
end

local function validate_secret_code(secret_code)
    local pyinitcfg = vim.fn.expand('$HOME/.pyinitcfg')
    if not utils.exists(pyinitcfg) then
        return false
    end
    local lines = lines_from(pyinitcfg)
    if #lines > 0 then
        for _, line in pairs(lines) do
            if line == secret_code then
                return true
            else
                return false
            end
        end
    else
        return false
    end
end

M["set_jedi_virtualenv"] = function(lsp_client)
    --print("client name: " .. lsp_client.name)
    local valid_lsps = {
        ["jedi_language_server"] = { is_jedi_interpreter_correct, create_interpreter_options_for_jedi },
    }
    local lsp_info = valid_lsps[lsp_client.name]
    if lsp_info ~= nil then
        local bufpath = vim.api.nvim_buf_get_name(0)
        local bufdir = vim.fs.dirname(bufpath)
        local find_results = vim.fs.find({ '.pyinit' }, { ['upward'] = true, ['path'] = bufdir })
        if #find_results == 1 then
            local pyinit = find_results[1]
            local lines = lines_from(pyinit)
            local pyexe = nil
            local secret_code = nil
            if #lines > 0 then
                --print(".pyinit found")
                for _, line in pairs(lines) do
                    local is_comment = line:find("#", 1, true) == 1
                    local is_blank   = line == nil or line:match("%S") == nil
                    if (not is_blank) and (not is_comment) and pyexe == nil then
                        pyexe = line
                    elseif (not is_blank) and (not is_comment) and secret_code == nil then
                        secret_code = line
                    end
                end
                --print("pyexe: " .. pyexe)
                local is_interpreter_correct = lsp_info[1]
                local needs_new = is_interpreter_correct(lsp_client, pyexe)
                local secret_valid = false
                if needs_new then
                    secret_valid = validate_secret_code(secret_code)
                end
                --print("needs_new: " .. tostring(needs_new))
                if needs_new and secret_valid then
                    local create_interpreter_options = lsp_info[2]
                    local init_options = create_interpreter_options(pyexe)

                    --print("init_options: " .. utils.tprint(init_options))
                    lsp_client.config.init_options = vim.tbl_deep_extend("force",
                        lsp_client.config.init_options, init_options)
                    local client_config = lsp_client.config
                    lsp_client.stop(true)
                    local new_client_id = vim.lsp.start_client(client_config)
                    vim.lsp.buf_attach_client(0, new_client_id)
                    --print("new client ID: " .. new_client_id)
                end
            end
        end
    end
end

return M
