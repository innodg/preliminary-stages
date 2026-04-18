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
    204     { return $true }
    404     { return $false }
    default { throw "Unexpected response (status: $statusCode).`n$output" }
}
