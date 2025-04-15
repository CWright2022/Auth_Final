#!/bin/bash

WEBHOOK="https://discord.com/api/webhooks/1359967845630480525/xU7uQavh8aGDJ2f_akIUDsC-TOLVavrIPz29zbfidPsQ9Yjk63b3LnXjNQdnK_mUUWq8"

send_webhook() {
    curl -H "Content-Type: application/json" \
         -X POST \
         -d "{\"content\": \"$1\"}" \
         "$WEBHOOK"
}

send_webhook ":rocket: Starting Test 19: John GPU (N/A threads), Dictionary mode"

echo "Running Test 19: John GPU (N/A threads), Dictionary mode"
OUTFILE="test19_results.txt"

echo "[*] Cracking WEAK passwords..." | tee -a "$OUTFILE"
send_webhook "[*] Cracking WEAK passwords..."
START=$(date +%s)
john --format=opencl/raw-sha256 --wordlist=rockyou.txt  hashes_weak.txt
END=$(date +%s)
echo "WEAK time: $((END - START)) seconds" | tee -a "$OUTFILE"
send_webhook "WEAK time: $((END - START)) seconds"

echo "[*] Cracking MEDIUM passwords..." | tee -a "$OUTFILE"
send_webhook "[*] Cracking MEDIUM passwords..."
START=$(date +%s)
john --format=opencl/raw-sha256 --wordlist=rockyou.txt  hashes_medium.txt
END=$(date +%s)
echo "MEDIUM time: $((END - START)) seconds" | tee -a "$OUTFILE"
send_webhook "MEDIUM time: $((END - START)) seconds"

echo "[*] Cracking STRONG passwords..." | tee -a "$OUTFILE"
send_webhook "[*] Cracking STRONG passwords..."
START=$(date +%s)
john --format=opencl/raw-sha256 --wordlist=rockyou.txt  hashes_strong.txt
END=$(date +%s)
echo "STRONG time: $((END - START)) seconds" | tee -a "$OUTFILE"
send_webhook "STRONG time: $((END - START)) seconds"


send_webhook ":white_check_mark: Test 19 complete! Check output file for time breakdown."