Param(
    [Parameter(Mandatory = $true)]
    [string] $GitHubOrg,

    [Parameter(Mandatory = $true)]
    [string] $GitHubId,

    [Parameter(Mandatory = $true)]
    [string] $TeamSlug
)

$userId = $(gh api /users/$GitHubId --jq '.id')
$teamId = $(gh api /orgs/$GitHubOrg/teams/$TeamSlug --jq '.id')
gh api --method POST /orgs/$GitHubOrg/invitations -F invitee_id=$userId -F "team_ids[]=$teamId"
