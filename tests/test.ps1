#!/usr/bin/env pwsh

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

try {
    Write-Host "Linking plugin for testing..."
    & mise plugin link --force cosmos . | Out-Null

    Write-Host "Clearing mise cache..."
    & mise cache clear | Out-Null
} catch {
    Write-Host "Error during setup: $_"
    exit 1
}

Write-Host "Testing plugin linking and basic functionality..."

$TEST_TOOL = 'make'
Write-Host "Testing version listing for $TEST_TOOL..."

# Exit-code tracking (0 = success, 1 = failure)
$EXIT_CODE = 0

# Try listing remote versions; check $LASTEXITCODE to determine success
& mise --debug ls-remote "cosmos:$TEST_TOOL"
if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ Version listing works"
} else {
    Write-Host "⚠ Version listing failed"
    $EXIT_CODE = 1
}

Write-Host "Testing installation..."

& mise --debug install "cosmos:$TEST_TOOL@latest"
if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ Installation works"

    # Test that the tool can be executed
    & mise exec "cosmos:$TEST_TOOL@latest" -- $TEST_TOOL --version
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ Tool execution works"
    } else {
        Write-Host "⚠ Tool execution failed"
        $EXIT_CODE = 1
    }
} else {
    Write-Host "⚠ Installation failed"
    $EXIT_CODE = 1
}

if ($EXIT_CODE -eq 0) {
    Write-Host "✓ Basic plugin structure tests completed"
}

exit $EXIT_CODE
