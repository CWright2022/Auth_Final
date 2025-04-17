$webhook = "https://discord.com/api/webhooks/1359967845630480525/xU7uQavh8aGDJ2f_akIUDsC-TOLVavrIPz29zbfidPsQ9Yjk63b3LnXjNQdnK_mUUWq8"

function Send-DiscordMessage($message) {
    Invoke-RestMethod -Uri $webhook -Method Post -Body (@{content = $message} | ConvertTo-Json) -ContentType 'application/json'
}
Send-DiscordMessage ":rocket: Starting test01: Hashcat CPU (2 threads), Dictionary mode"
$OutputFile = "results/test01_results.txt"
"" | Out-File -FilePath $OutputFile

Send-DiscordMessage ":hourglass: Starting Weak hashes"
Remove-Item -ErrorAction SilentlyContinue hashcat.potfile

$startTime = Get-Date

cmd /c "cd hashcat && hashcat.exe -m 1400 -a 0 --potfile-disable --opencl-device-types 1 --cpu-affinity=2 ..\hashes\hashes_weak.txt ..\realuniq.lst -O" | Tee-Object -FilePath $OutputFile -Append
$endTime = Get-Date
$elapsed = ($endTime - $startTime).TotalSeconds
Send-DiscordMessage ":white_check_mark: Finished Weak in $($elapsed) seconds."

Send-DiscordMessage ":hourglass: Starting Medium hashes"
Remove-Item -ErrorAction SilentlyContinue hashcat.potfile
$startTime = Get-Date
cmd /c "cd hashcat && hashcat.exe -m 1400 -a 0 --potfile-disable --opencl-device-types 1 --cpu-affinity=2 ..\hashes\hashes_medium.txt ..\realuniq.lst -O" | Tee-Object -FilePath $OutputFile -Append
$endTime = Get-Date
$elapsed = ($endTime - $startTime).TotalSeconds
Send-DiscordMessage ":white_check_mark: Finished Medium in $($elapsed) seconds."

Send-DiscordMessage ":hourglass: Starting Strong hashes"
Remove-Item -ErrorAction SilentlyContinue hashcat.potfile

$startTime = Get-Date

cmd /c "cd hashcat && hashcat.exe -m 1400 -a 0 --potfile-disable --opencl-device-types 1 --cpu-affinity=2 ..\hashes\hashes_strong.txt ..\realuniq.lst -O" | Tee-Object -FilePath $OutputFile -Append

$endTime = Get-Date
$elapsed = ($endTime - $startTime).TotalSeconds
Send-DiscordMessage ":white_check_mark: Finished Strong in $($elapsed) seconds."

Send-DiscordMessage ":checkered_flag: test01 complete!"