Param(
    [Parameter(Mandatory = $true)]
    [string] $GitHubOrg,

    [Parameter(Mandatory = $true)]
    [string] $GitHubId
)

$userId = $(gh api users/$GitHubId --jq '.id')
gh api --method POST /orgs/$GitHubOrg/invitations -F invitee_id=$userId
