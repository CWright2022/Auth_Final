$webhook = "https://discord.com/api/webhooks/1359967845630480525/xU7uQavh8aGDJ2f_akIUDsC-TOLVavrIPz29zbfidPsQ9Yjk63b3LnXjNQdnK_mUUWq8"

function Send-DiscordMessage($message) {
    Invoke-RestMethod -Uri $webhook -Method Post -Body (@{content = $message} | ConvertTo-Json) -ContentType 'application/json'
}
Send-DiscordMessage ":rocket: Starting test02: Hashcat CPU (4 threads), Dictionary mode"
$OutputFile = "test02_results.txt"
"" | Out-File -FilePath $OutputFile

Send-DiscordMessage ":hourglass: Starting Weak hashes"
$startTime = Get-Date
Remove-Item -ErrorAction SilentlyContinue hashcat.potfile
cmd /c "hashcat.exe -m 1400 -a 0 --potfile-disable --opencl-device-types 1 -n 4 hashes_weak.txt rockyou.txt -O" | Tee-Object -FilePath $OutputFile -Append
$endTime = Get-Date
$elapsed = ($endTime - $startTime).TotalSeconds
Send-DiscordMessage ":white_check_mark: Finished Weak in $($elapsed) seconds."

Send-DiscordMessage ":hourglass: Starting Medium hashes"
$startTime = Get-Date
Remove-Item -ErrorAction SilentlyContinue hashcat.potfile
cmd /c "hashcat.exe -m 1400 -a 0 --potfile-disable --opencl-device-types 1 -n 4 hashes_medium.txt rockyou.txt -O" | Tee-Object -FilePath $OutputFile -Append
$endTime = Get-Date
$elapsed = ($endTime - $startTime).TotalSeconds
Send-DiscordMessage ":white_check_mark: Finished Medium in $($elapsed) seconds."

Send-DiscordMessage ":hourglass: Starting Strong hashes"
$startTime = Get-Date
Remove-Item -ErrorAction SilentlyContinue hashcat.potfile
cmd /c "hashcat.exe -m 1400 -a 0 --potfile-disable --opencl-device-types 1 -n 4 hashes_strong.txt rockyou.txt -O" | Tee-Object -FilePath $OutputFile -Append
$endTime = Get-Date
$elapsed = ($endTime - $startTime).TotalSeconds
Send-DiscordMessage ":white_check_mark: Finished Strong in $($elapsed) seconds."

Send-DiscordMessage ":checkered_flag: test02 complete!"