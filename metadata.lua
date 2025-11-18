-- metadata.lua
-- Backend plugin metadata and configuration
-- Documentation: https://mise.jdx.dev/backend-plugin-development.html

PLUGIN = { -- luacheck: ignore
    -- Required: Plugin name (will be the backend name users reference)
    name = "cosmos",

    -- Required: Plugin version (not the tool versions)
    version = "1.0.0",

    -- Required: Brief description of the backend and tools it manages
    description = "A mise backend plugin for cosmos tools",

    -- Required: Plugin author/maintainer
    author = "moshen",

    -- Optional: Plugin homepage/repository URL
    homepage = "https://github.com/moshen/cosmos-mise-backend-plugin",

    -- Optional: Plugin license
    license = "MIT",

    -- Optional: Important notes for users
    notes = {
        -- "This plugin manages tools from the cosmopolitan ecosystem"
        -- "useful for installing individual compatible programs"
    },
}
