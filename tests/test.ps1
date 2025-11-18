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
try {
    & mise ls-remote "cosmos:$TEST_TOOL" 2>$null | Out-Null
    Write-Host "✓ Version listing works"
} catch {
    Write-Host "⚠ Version listing failed - implement backend_list_versions.lua for your backend"
}

Write-Host "Testing installation..."
try {
    & mise install "cosmos:$TEST_TOOL@latest" 2>$null | Out-Null
    Write-Host "✓ Installation works"

    try {
        & mise exec "cosmos:$TEST_TOOL@latest" -- $TEST_TOOL --version 2>$null | Out-Null
        Write-Host "✓ Tool execution works"
    } catch {
        Write-Host "⚠ Tool execution failed - check backend_exec_env.lua implementation"
    }
} catch {
    Write-Host "⚠ Installation failed"
}

Write-Host "✓ Basic plugin structure tests completed"
