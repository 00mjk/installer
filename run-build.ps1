#
# Copyright (c) .NET Foundation and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for full license information.
#

[CmdletBinding(PositionalBinding=$false)]
param(
    [string]$Configuration="Debug",
    [string]$Architecture="x64",
    [Parameter(ValueFromRemainingArguments=$true)][String[]]$ExtraParameters
)

$RepoRoot = "$PSScriptRoot"

$ArchitectureParam="/p:Architecture=$Architecture"
$ConfigurationParam="-configuration $Configuration"
try {
    $ExpressionToInvoke = "$RepoRoot\eng\common\build.ps1 -restore -build $ConfigurationParam $ArchitectureParam $ExtraParameters"
    Write-Host "Invoking expression: $ExpressionToInvoke"
    Invoke-Expression $ExpressionToInvoke
}
catch {
 Write-Error $_
 Write-Error $_.ScriptStackTrace
 throw "Failed to build"
}

if($LASTEXITCODE -ne 0) { throw "Failed to build" }