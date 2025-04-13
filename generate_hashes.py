import hashlib

# --- Define password categories (expanded with passphrases) ---

weak_passwords = [
    "123456", "password", "qwerty", "111111", "123123",
    "abc123", "letmein", "000000", "iloveyou", "monkey",
    "i love you", "password123", "my password", "q w e r t y", "guest login",
    "welcome123", "pass word", "test1234", "football", "baseball",
    "princess", "dragon", "passw0rd", "master", "hello",
    "whatever", "asdfgh", "zxcvbn", "trustno1", "654321",
    "just a test", "let me in", "nothing here", "guessme", "access denied",
    "hello world", "default user", "open sesame", "knock knock", "let me pass",
    "shadow", "superman", "batman", "jordan", "harley",
    "hunter", "buster", "soccer", "killer", "pepper"
]

medium_passwords = [
    "Spring2024", "CoffeeMug1", "Sunshine22", "NewYork123", "PurpleMoon",
    "PizzaTime9", "HappyFeet7", "BubbleTea2", "Ocean breeze 3", "MangoJuice!",
    "My laptop 55", "GreenSky12", "Chocolate88", "WinterSnow", "RedDragon7",
    "Moon light magic", "GuitarHero", "OrangeZebra", "Crazy cat 22", "TravelBug",
    "FlowerPower", "BaconEggs", "NiceTry77", "Coconut77", "SodaPop99",
    "the quick fox", "why not try", "fast and curious", "weekend getaway", "drive safe now",
    "cloud walker", "street lights", "rain drops fall", "look behind you", "silent night",
    "Bright day today", "island fun 4", "HappyTimes", "JungleJim9", "FastCar55",
    "CozyBlanket", "MovieBuff1", "Study time 3", "CleanRoom9", "LaptopBag",
    "Nice view 88", "GoldenSun", "Keyboard99", "Science42", "MathTime3"
]

strong_passwords = [
    "L@pt0p^Sup3r!Secure", "T1m3!2#HackTh3W0rld", "Dun3@Arrakis*2025",
    "My car's faster than yours!", "I have 2 cats and a dog!", "W!nter is c0ming s00n",
    "My password is not password", "Why did I make this pass?", "There is no spoon!",
    "Tr0ub4dor&$2024", "Z3r0Day&N1ght", "Op3n$3sam3!", "Hard to guess me now",
    "H@ckM3!N0w", "Th3M@tr1x$Awak3ns", "Encrypt3d!Th0ught5", "B3Y0nd$Th3$W@ll",
    "Unbr34k@ble*2025", "Wh0@Am1^N3ow?", "9L1v3s@G0!", "Galaxy hopping soon!",
    "the end of all passwords!", "no more secrets for you!", "can't crack this today!",
    "Expl0it!B0x^2024", "deep learning is overrated",
    "r00t!Acc3ss#Plz", "OpenAI^Sec2024!", "JumpHost*Bypass", "CrypT1c!W1z@rd",
    "D@t@Knight$$", "Brut3!Force^Ev3r", "DeepF@ke$2024", "SecOps$Galaxy!",
    "my voice is my passport", "never gonna give you up!", "this is a long password lol",
    "please let this work!", "hovercraft full of eels", "thunderstorm over Neptune",
    "HashBr0wn!Secure", "Wiresh@rk!Logz", "K3ym@sh!N3#X", "darkness beyond twilight",
    "we live in a simulation", "nothing personnel kid", "keyboard warrior activated",
    "Hack!Th3Pl@net", "Space is big and scary", "cracking? not today satan"
]

all_passwords = (
    [p for p in weak_passwords] +
    [p for p in medium_passwords] +
    [p for p in strong_passwords]
)

# --- Hashing ---
def sha256_hash(password: str) -> str:
    return hashlib.sha256(password.encode()).hexdigest()

with open("./hashes/hashes_weak.txt", "w") as hashfile:
    for password in weak_passwords:
        hash_value=sha256_hash(password)
        hashfile.write(f"{hash_value}\n")

with open("./hashes/hashes_medium.txt", "w") as hashfile:
    for password in medium_passwords:
        hash_value=sha256_hash(password)
        hashfile.write(f"{hash_value}\n")

with open("./hashes/hashes_strong.txt", "w") as hashfile:
    for password in strong_passwords:
        hash_value=sha256_hash(password)
        hashfile.write(f"{hash_value}\n")

min_length=999
max_length=0
for password in all_passwords:
    length = len(password)
    if length > max_length:
        max_length = length
    if length < min_length:
        min_length = length

print(f"MAX LENGTH: {max_length}")
print(f"MIN LENGTH: {min_length}")