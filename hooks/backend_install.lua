-- hooks/backend_install.lua
-- Installs a specific version of a tool
-- Documentation: https://mise.jdx.dev/backend-plugin-development.html#backendinstall

function PLUGIN:BackendInstall(ctx)
    local tool = ctx.tool
    local version = ctx.version
    local install_path = ctx.install_path

    -- Validate inputs
    if not tool or tool == "" then
        error("Tool name cannot be empty")
    end
    if not version or version == "" then
        error("Version cannot be empty")
    end
    if not install_path or install_path == "" then
        error("Install path cannot be empty")
    end

    -- Create installation directory
    local cmd = require("cmd")
    local file = require("file")
    local http = require("http")

    -- Construct download URL
    local platform = RUNTIME.osType:lower()
    local arch = RUNTIME.archType
    local download_url = "https://cosmo.zip/pub/cosmos/v/" .. version .. "/bin/" .. tool

    -- Download the tool
    local temp_file = install_path .. "/" .. tool
    local resp, err = http.download_file({
        url = download_url,
    }, temp_file)
    if platform == "windows" then
        file.symlink(temp_file, temp_file .. ".exe")
    end

    if err then
        error("Failed to download " .. tool .. "@" .. version .. ": " .. err)
    end

    -- Set executable permissions
    if platform ~= "windows" then
        cmd.exec("chmod +x " .. install_path .. "/" .. tool)
    end

    return {}
end
