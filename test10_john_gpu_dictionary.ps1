$webhook = "https://discord.com/api/webhooks/1359967845630480525/xU7uQavh8aGDJ2f_akIUDsC-TOLVavrIPz29zbfidPsQ9Yjk63b3LnXjNQdnK_mUUWq8"

function Send-DiscordMessage($message) {
    Invoke-RestMethod -Uri $webhook -Method Post -Body (@{content = $message} | ConvertTo-Json) -ContentType 'application/json'
}
Send-DiscordMessage ":rocket: Starting test10: John GPU (N/A threads), Dictionary mode"
$OutputFile = "test10_results.txt"
"" | Out-File -FilePath $OutputFile

Send-DiscordMessage ":hourglass: Starting Weak hashes"
$startTime = Get-Date
Remove-Item -ErrorAction SilentlyContinue john.pot
cmd /c "john.exe --format=opencl/raw-sha256 --wordlist=rockyou.txt  hashes_weak.txt" | Tee-Object -FilePath $OutputFile -Append
$endTime = Get-Date
$elapsed = ($endTime - $startTime).TotalSeconds
Send-DiscordMessage ":white_check_mark: Finished Weak in $($elapsed) seconds."

Send-DiscordMessage ":hourglass: Starting Medium hashes"
$startTime = Get-Date
Remove-Item -ErrorAction SilentlyContinue john.pot
cmd /c "john.exe --format=opencl/raw-sha256 --wordlist=rockyou.txt  hashes_medium.txt" | Tee-Object -FilePath $OutputFile -Append
$endTime = Get-Date
$elapsed = ($endTime - $startTime).TotalSeconds
Send-DiscordMessage ":white_check_mark: Finished Medium in $($elapsed) seconds."

Send-DiscordMessage ":hourglass: Starting Strong hashes"
$startTime = Get-Date
Remove-Item -ErrorAction SilentlyContinue john.pot
cmd /c "john.exe --format=opencl/raw-sha256 --wordlist=rockyou.txt  hashes_strong.txt" | Tee-Object -FilePath $OutputFile -Append
$endTime = Get-Date
$elapsed = ($endTime - $startTime).TotalSeconds
Send-DiscordMessage ":white_check_mark: Finished Strong in $($elapsed) seconds."

Send-DiscordMessage ":checkered_flag: test10 complete!"