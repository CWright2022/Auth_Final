$webhook = "https://discord.com/api/webhooks/1359967845630480525/xU7uQavh8aGDJ2f_akIUDsC-TOLVavrIPz29zbfidPsQ9Yjk63b3LnXjNQdnK_mUUWq8"

function Send-DiscordMessage($message) {
    Invoke-RestMethod -Uri $webhook -Method Post -Body (@{content = $message} | ConvertTo-Json) -ContentType 'application/json'
}
Send-DiscordMessage ":rocket: Starting test08: John CPU (6 threads), Dictionary mode"
$OutputFile = "results/test08_results.txt"
"" | Out-File -FilePath $OutputFile

Send-DiscordMessage ":hourglass: Starting Weak hashes"
Remove-Item -ErrorAction SilentlyContinue john/run/john.pot

$startTime = Get-Date

cmd /c "cd john/run && john.exe --format=raw-sha256 --wordlist=..\..\realuniq.lst --fork=6 ..\..\hashes\hashes_weak.txt" | Tee-Object -FilePath $OutputFile
cmd /c "cd john/run && john.exe --show --format=raw-sha256 ..\..\hashes\hashes_weak.txt" | Tee-Object -FilePath $OutputFile

$endTime = Get-Date
$elapsed = ($endTime - $startTime).TotalSeconds
Send-DiscordMessage ":white_check_mark: Finished Weak in $($elapsed) seconds."

Send-DiscordMessage ":hourglass: Starting Medium hashes"
Remove-Item -ErrorAction SilentlyContinue john/run/john.pot

$startTime = Get-Date

cmd /c "cd john/run && john.exe --format=raw-sha256 --wordlist=..\..\realuniq.lst --fork=6 ..\..\hashes\hashes_medium.txt" | Tee-Object -FilePath $OutputFile
cmd /c "cd john/run && john.exe --show --format=raw-sha256 ..\..\hashes\hashes_medium.txt" | Tee-Object -FilePath $OutputFile

$endTime = Get-Date
$elapsed = ($endTime - $startTime).TotalSeconds
Send-DiscordMessage ":white_check_mark: Finished Medium in $($elapsed) seconds."

Send-DiscordMessage ":hourglass: Starting Strong hashes"
Remove-Item -ErrorAction SilentlyContinue john/run/john.pot

$startTime = Get-Date

cmd /c "cd john/run && john.exe --format=raw-sha256 --wordlist=..\..\realuniq.lst --fork=6 ..\..\hashes\hashes_strong.txt" | Tee-Object -FilePath $OutputFile
cmd /c "cd john/run && john.exe --show --format=raw-sha256 ..\..\hashes\hashes_strong.txt" | Tee-Object -FilePath $OutputFile

$endTime = Get-Date
$elapsed = ($endTime - $startTime).TotalSeconds
Send-DiscordMessage ":white_check_mark: Finished Strong in $($elapsed) seconds."

Send-DiscordMessage ":checkered_flag: test08 complete!"