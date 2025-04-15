$webhook = "https://discord.com/api/webhooks/1359967845630480525/xU7uQavh8aGDJ2f_akIUDsC-TOLVavrIPz29zbfidPsQ9Yjk63b3LnXjNQdnK_mUUWq8"

function Send-DiscordMessage($message) {
    Invoke-RestMethod -Uri $webhook -Method Post -Body (@{content = $message} | ConvertTo-Json) -ContentType 'application/json'
}
Send-DiscordMessage ":rocket: Starting test08: John CPU (6 threads), Dictionary mode"
$OutputFile = "test08_results.txt"
"" | Out-File -FilePath $OutputFile

Send-DiscordMessage ":hourglass: Starting Weak hashes"
Remove-Item -ErrorAction SilentlyContinue hashcat.potfile
Remove-Item -ErrorAction SilentlyContinue $env:TEMP\test08_Weak_temp.txt
$startTime = Get-Date
Push-Location "$PSScriptRoot\..\john"
cmd /c "john.exe --format=raw-sha256 --wordlist=..\rockyou.txt --fork=6 ..\hashes_weak.txt" | Tee-Object -FilePath $env:TEMP\test08_Weak_temp.txt
Pop-Location
Get-Content $env:TEMP\test08_Weak_temp.txt | Add-Content $OutputFile
$recoveredLine = Select-String -Path $env:TEMP\test08_Weak_temp.txt -Pattern "^Recovered" | Select-Object -Last 1
if ($recoveredLine) {
    $lineText = $recoveredLine.ToString().Trim()
    Send-DiscordMessage ":lock_with_ink_pen: [Weak] $lineText"
} else {
    Send-DiscordMessage ":warning: [Weak] Could not find recovery stats."
}
$endTime = Get-Date
$elapsed = ($endTime - $startTime).TotalSeconds
Send-DiscordMessage ":white_check_mark: Finished Weak in $($elapsed) seconds."

Send-DiscordMessage ":hourglass: Starting Medium hashes"
Remove-Item -ErrorAction SilentlyContinue hashcat.potfile
Remove-Item -ErrorAction SilentlyContinue $env:TEMP\test08_Medium_temp.txt
$startTime = Get-Date
Push-Location "$PSScriptRoot\..\john"
cmd /c "john.exe --format=raw-sha256 --wordlist=..\rockyou.txt --fork=6 ..\hashes_medium.txt" | Tee-Object -FilePath $env:TEMP\test08_Medium_temp.txt
Pop-Location
Get-Content $env:TEMP\test08_Medium_temp.txt | Add-Content $OutputFile
$recoveredLine = Select-String -Path $env:TEMP\test08_Medium_temp.txt -Pattern "^Recovered" | Select-Object -Last 1
if ($recoveredLine) {
    $lineText = $recoveredLine.ToString().Trim()
    Send-DiscordMessage ":lock_with_ink_pen: [Medium] $lineText"
} else {
    Send-DiscordMessage ":warning: [Medium] Could not find recovery stats."
}
$endTime = Get-Date
$elapsed = ($endTime - $startTime).TotalSeconds
Send-DiscordMessage ":white_check_mark: Finished Medium in $($elapsed) seconds."

Send-DiscordMessage ":hourglass: Starting Strong hashes"
Remove-Item -ErrorAction SilentlyContinue hashcat.potfile
Remove-Item -ErrorAction SilentlyContinue $env:TEMP\test08_Strong_temp.txt
$startTime = Get-Date
Push-Location "$PSScriptRoot\..\john"
cmd /c "john.exe --format=raw-sha256 --wordlist=..\rockyou.txt --fork=6 ..\hashes_strong.txt" | Tee-Object -FilePath $env:TEMP\test08_Strong_temp.txt
Pop-Location
Get-Content $env:TEMP\test08_Strong_temp.txt | Add-Content $OutputFile
$recoveredLine = Select-String -Path $env:TEMP\test08_Strong_temp.txt -Pattern "^Recovered" | Select-Object -Last 1
if ($recoveredLine) {
    $lineText = $recoveredLine.ToString().Trim()
    Send-DiscordMessage ":lock_with_ink_pen: [Strong] $lineText"
} else {
    Send-DiscordMessage ":warning: [Strong] Could not find recovery stats."
}
$endTime = Get-Date
$elapsed = ($endTime - $startTime).TotalSeconds
Send-DiscordMessage ":white_check_mark: Finished Strong in $($elapsed) seconds."

Send-DiscordMessage ":checkered_flag: test08 complete!"