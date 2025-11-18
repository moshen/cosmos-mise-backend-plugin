-- hooks/backend_list_versions.lua
-- Lists available versions for a tool in this backend
-- Documentation: https://mise.jdx.dev/backend-plugin-development.html#backendlistversions

function PLUGIN:BackendListVersions(ctx)
    local tool = ctx.tool

    -- Validate tool name
    if not tool or tool == "" then
        error("Tool name cannot be empty")
    end

    local http = require("http")

    -- Replace with your backend's API endpoint
    local v_url = "https://cosmo.zip/pub/cosmos/v/"

    local version_resp, version_err = http.get({
        url = v_url,
    })

    if version_err then
        error("Failed to fetch versions for " .. tool .. ": " .. version_err)
    end

    if version_resp.status_code ~= 200 then
        error("API returned status " .. version_resp.status_code .. " for " .. tool)
    end

    local avail_versions = {}
    for avail_version in version_resp.body:gmatch('href="(%d[%d%.]*)/"') do
        table.insert(avail_versions, avail_version)
    end

    local ordered_keys = {}

    for k in pairs(avail_versions) do
        table.insert(ordered_keys, k)
    end

    table.sort(ordered_keys)
    local versions = {}
    for i = 1, #ordered_keys do
        local k, v = ordered_keys[i], avail_versions[ordered_keys[i]]

        local resp, err = http.get({
            url = v_url .. v .. "/bin/",
        })

        if err then
            error("Failed to fetch versions for " .. tool .. ": " .. err)
        end

        if resp.status_code ~= 200 then
            error("API returned status " .. resp.status_code .. " for " .. tool)
        end

        -- Find tool
        local find_res = resp.body:find('href="' .. tool .. '"', 1, true)

        if find_res then
            table.insert(versions, v)
        end
    end

    if #versions == 0 then
        error("No versions found for " .. tool)
    end

    return { versions = versions }
end
