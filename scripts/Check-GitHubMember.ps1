param(
    [string]$Organization = "innodg",

    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string]$Username
)

$ErrorActionPreference = 'Stop'

$endpoint = "orgs/$Organization/members/$Username"

$output = & gh api $endpoint -i 2>&1

$statusLine = ($output | Select-Object -First 1) -as [string]
$statusCode = $null
if ($statusLine -match 'HTTP/[\d\.]+\s+(\d{3})') {
    $statusCode = [int]$Matches[1]
}

switch ($statusCode) {
    204     { $result = $true.ToString().ToLower(); break }
    404     { $result = $false.ToString().ToLower(); break }
    default { throw "Unexpected response (status: $statusCode).`n$output" }
}

# Reset exit code: `gh api` exits non-zero on 404, which would otherwise
# propagate as the script's process exit code.
$global:LASTEXITCODE = 0
Write-Output $result
exit 0
