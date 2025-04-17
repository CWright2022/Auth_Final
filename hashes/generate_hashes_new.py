import hashlib
import random

# ---------------------
def sha256_hash(password: str) -> str:
    return hashlib.sha256(password.encode()).hexdigest()

def expand_passwords(base_list, target_count):
    expanded = set(base_list)
    while len(expanded) < target_count:
        base = random.choice(base_list)
        mutation = base + str(random.randint(10, 99999))
        if random.random() > 0.7:
            mutation = mutation.replace('a', '@').replace('s', '$').replace('o', '0').replace('i', '1')
        expanded.add(mutation)
    return list(expanded)

# ---------------------
# 100 manually curated seeds per category (examples below abbreviated for brevity)
weak_base = ["123456", "password", "abc123", "iloveyou", "admin", "welcome", "guest", "monkey", "letmein", "football",
             "sunshine", "princess", "qwerty", "dragon", "shadow", "654321", "superman", "batman", "michael", "hunter",
             "cheese", "computer", "mobile", "google", "test123", "access", "unknown", "login", "trustno1", "pass123"] * 4

medium_base = ["Summer22", "BlueSky8", "Laptop2024", "CoffeeCup3", "MagicDoor2", "GreenTea7", "OceanView8", "RainyDay7",
               "NightSky3", "Cloud99", "BrightSun", "FlowerPot2", "MathTime4", "ScienceLab", "BeachTrip", "WorkHard4",
               "MovieNight", "QuietTime4", "ChillMode7", "HappyDay4", "SmartGuy9", "PhoneCase", "TVRemote2", "FastLane9",
               "SneakyCat6", "SoftPillow", "RunFast22", "ZooVisit7", "GrapeJuice", "Popcorn99"] * 4

strong_base = ["L@pt0p^Sup3r!Secure", "T1m3!2#HackTh3W0rld", "Dun3@Arrakis*2025", "Tr0ub4dor&$2024",
               "My car's faster than yours!", "W!nter is c0ming s00n", "GalaxyFar&F@stAway",
               "Wiresh@rk!Detect3d", "Keyboard!Sm@sh2025", "DarkM0de_Only!", "Hack!Th3Pl@net",
               "Expl0it@YourOwnRisk", "PleaseD0n'tHack_Me", "C@llM3_@dmiral0fP@ssphrases",
               "Br@1ns>BruteF0rce", "MyPasswordIsUnbreakable", "C0mm@nd+N+C0nquer$", "Can'tCrackM3$Today",
               "N0!B0rder$Here", "Space is big and scary", "StopRightThereCr1minal", "CrypT1c!W1z@rd",
               "Punch+Th3+P@cket", "Hovercraft full of eels", "Smart$@fe2025!", "JumpHost++Bypass"] * 4

# Ensure exactly 100 items for mutation base
weak_base = weak_base[:100]
medium_base = medium_base[:100]
strong_base = strong_base[:100]

# ---------------------
# Generate full password sets
weak_passwords = expand_passwords(weak_base, 1000)
medium_passwords = expand_passwords(medium_base, 1000)
strong_passwords = expand_passwords(strong_base, 1000)

# ---------------------
# Hash and write to output files
with open("plaintexts_labeled.txt", "w") as plain_out, \
     open("sha256_hashes_labeled.txt", "w") as labeled_out, \
     open("hashes_weak.txt", "w") as weak_out, \
     open("hashes_medium.txt", "w") as medium_out, \
     open("hashes_strong.txt", "w") as strong_out:

    for label, pw_list, out_file in [
        ("weak", weak_passwords, weak_out),
        ("medium", medium_passwords, medium_out),
        ("strong", strong_passwords, strong_out)
    ]:
        for pwd in pw_list:
            h = sha256_hash(pwd)
            out_file.write(h + "\n")
            labeled_out.write(f"{label}:{h}\n")
            plain_out.write(f"{label}:{pwd}\n")

print("✅ Done! Generated 3,000 SHA-256 hashed passwords (1,000 per category).")
