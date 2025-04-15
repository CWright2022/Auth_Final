param(
    [int]$StartTest = 1,
    [int]$EndTest = 10
)

for ($i = $StartTest; $i -le $EndTest; $i++) {
    $script = Get-ChildItem -Path . -Filter ('test{0:d2}*.ps1' -f $i) | Select-Object -First 1
    if ($script) {
        Write-Host "Running $($script.Name)..."
        powershell -ExecutionPolicy Bypass -File $script.FullName
    } else {
        Write-Host "Script for test $i not found."
    }
}