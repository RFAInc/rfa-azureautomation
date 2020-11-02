function Install-MicrosoftMonitoringAgent{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$WorkspaceID,
        [Parameter(Mandatory=$true)]
        [string]$WorkspaceKey,
        [Parameter(Mandatory=$false)]
        [ValidateSet("64-bit", "32-bit")]
        [string]$Architecture = "64-bit",
        [Parameter(Mandatory=$false)] 
        [String] [String] $DLPath = (Get-Location).Path
    )
    $DLLink = switch ($Architecture){
        '64-bit' {'https://go.microsoft.com/fwlink/?LinkId=828603'} 
        '32-bit' {'https://go.microsoft.com/fwlink/?LinkId=828604'}
    }
    $PackagePath = "$DLPath\MMA_$Architecture.exe"
    (New-Object System.Net.WebClient).DownloadFile($DLLink, "$DLPath")
    $Arguments = '/C:"setup.exe /qn ADD_OPINSIGHTS_WORKSPACE=1 '+  "OPINSIGHTS_WORKSPACE_ID=$WorkspaceID " + "OPINSIGHTS_WORKSPACE_KEY=$WorkspaceKey " +'AcceptEndUserLicenseAgreement=1"'
    Start-Process $PackagePath -ArgumentList $Arguments
}