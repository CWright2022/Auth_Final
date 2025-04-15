#!/bin/bash

WEBHOOK="https://discord.com/api/webhooks/1359967845630480525/xU7uQavh8aGDJ2f_akIUDsC-TOLVavrIPz29zbfidPsQ9Yjk63b3LnXjNQdnK_mUUWq8"

send_webhook() {
    curl -H "Content-Type: application/json" \
         -X POST \
         -d "{\"content\": \"$1\"}" \
         "$WEBHOOK"
}

send_webhook ":rocket: Starting Test 03: Hashcat CPU (2 threads), Dictionary mode"

echo "Running Test 03: Hashcat CPU (2 threads), Dictionary mode"
OUTFILE="test03_results.txt"

echo "[*] Cracking WEAK passwords..." | tee -a "$OUTFILE"
send_webhook "[*] Cracking WEAK passwords..."
START=$(date +%s)
hashcat -m 1400 -a 0 -O --force --opencl-device-types 1  --cpu-affinity=2 hashes_weak.txt rockyou.txt
END=$(date +%s)
echo "WEAK time: $((END - START)) seconds" | tee -a "$OUTFILE"
send_webhook "WEAK time: $((END - START)) seconds"

echo "[*] Cracking MEDIUM passwords..." | tee -a "$OUTFILE"
send_webhook "[*] Cracking MEDIUM passwords..."
START=$(date +%s)
hashcat -m 1400 -a 0 -O --force --opencl-device-types 1  --cpu-affinity=2 hashes_medium.txt rockyou.txt
END=$(date +%s)
echo "MEDIUM time: $((END - START)) seconds" | tee -a "$OUTFILE"
send_webhook "MEDIUM time: $((END - START)) seconds"

echo "[*] Cracking STRONG passwords..." | tee -a "$OUTFILE"
send_webhook "[*] Cracking STRONG passwords..."
START=$(date +%s)
hashcat -m 1400 -a 0 -O --force --opencl-device-types 1  --cpu-affinity=2 hashes_strong.txt rockyou.txt
END=$(date +%s)
echo "STRONG time: $((END - START)) seconds" | tee -a "$OUTFILE"
send_webhook "STRONG time: $((END - START)) seconds"


send_webhook ":white_check_mark: Test 03 complete! Check output file for time breakdown."