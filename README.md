# Cosmos mise backend plugin

Provides the capability to install [cosmopolitan libc cosmos
programs](https://cosmo.zip/pub/cosmos/v/) via mise.

## Why would I want to do this?

Cosmos programs are an easy way to provide a consistent environment for building
software across platforms.

`make` and `clang-format` are a couple of examples of applications you can
easily standardize across systems with mise (including Windows).

## Setup Instructions

Add the plugin

```shell
mise plugin install cosmos https://github.com/moshen/cosmos-mise-backend-plugin
```

Install cosmos programs

```shell
mise install cosmos:make@latest
```

On Windows the program is symlinked to `<tool>.exe` for easy execution and so
that if you install several programs from cosmos, they will work together in
`bash`.

## Development Workflow

### Setting up development environment

1. Install pre-commit hooks (optional but recommended):
```bash
hk install
```

This sets up automatic linting and formatting on git commits.

### Local Testing

1. Link your plugin for development:
```bash
mise plugin link --force cosmos .
```

2. Test version listing:
```bash
mise ls-remote cosmos:<some-tool>
```

3. Test installation:
```bash
mise install cosmos:<some-tool>@latest
```

4. Test execution:
```bash
mise exec cosmos:<some-tool>@latest -- <some-tool> --version
```

5. Run tests:
```bash
mise run test
```

6. Run linting:
```bash
mise run lint
```

7. Run full CI suite:
```bash
mise run ci
```

### Code Quality

This template uses [hk](https://hk.jdx.dev) for modern linting and pre-commit hooks:

- **Automatic formatting**: `stylua` formats Lua code
- **Static analysis**: `luacheck` catches Lua issues  
- **GitHub Actions linting**: `actionlint` validates workflows
- **Pre-commit hooks**: Runs all checks automatically on git commit

Manual commands:
```bash
hk check      # Run all linters (same as mise run lint)
hk fix        # Run linters and auto-fix issues
```

### Debugging

Enable debug output:
```bash
mise --debug install cosmos:<tool>@<version>
```

## License

MIT
