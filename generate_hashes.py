import hashlib

# --- Define password categories (expanded with passphrases) ---

weak_passwords = [
    "123456", "password", "123123", "qwerty", "abc123", "111111", "letmein", "welcome", "monkey", "iloveyou000000", "pass123", "hello123", "1q2w3e", "654321", "admin", "shadow", "trustno1", "dragon", "princesssunshine", "football", "baseball", "michael", "jordan", "hunter", "soccer", "batman", "superman", "qazwsxasdfgh", "zxcvbn", "1qaz2wsx", "passw0rd", "guest", "love123", "charlie", "buster", "pepper", "tigercheese", "computer", "mobile", "secret", "naruto", "pokemon", "blink182", "iloveu", "test1234", "killer123abc", "321321", "qwertyui", "asdf1234", "coffee", "flower", "google", "nothing", "dolphin", "sparklehappy123", "12qwaszx", "login123", "user1", "letmein1", "passcode", "phone123", "camera123", "basicpass", "nopassword", "tryagain", "access", "mypass", "winter", "summer", "friday", "thursday", "blue123", "red456", "star789apple123", "banana1", "grapes22", "fruit123", "password1", "hacker", "unknown", "welcome1", "passme", "777777ilikecats", "ilikedogs", "abcdefg", "onetwothree", "dog123", "cat456", "fish789", "laptop123", "printer1", "justme"
]

medium_passwords = [
    "Summer22", "BlueSky8", "Laptop2024", "BookWorm9", "MyPhone3", "MangoJuice7", "Pineapple99", "CatLover1", "DogHouse5", "PizzaTimeCoffeeCup3", "MagicDoor2", "CarDrive88", "HappyDay4", "SkyHigh1", "Cloud99", "MouseTrap7", "BrightSun", "FlowerPot2", "PlantLove5GreenTea7", "OrangeRain", "Keyboard9", "TVRemote2", "SchoolBus", "BusStop10", "StudyTime1", "MathTime4", "ScienceLab", "BeachTripOceanView8", "Sunset12", "RainyDay7", "GrapeJuice", "NightSky3", "SpaceWalk", "Rocket77", "StarDust1", "CleanDesk", "LoudMusic3MoonLight9", "CrazyDay2", "WorkHard4", "ChillMode7", "CalmMind1", "Lemonade5", "Popcorn99", "TurtleRun3", "BananaBoat", "CarWash8PhotoSnap4", "DailyWalk", "ParkBench", "SnowFall2", "FreeTime1", "MovieNight", "RedShirt9", "BluePants", "SweetHome", "JungleGym5FunTimes2", "Password77", "CityRoad3", "MagicLand", "ForestWalk", "CandyLand", "SleepNow5", "DreamBig3", "QuietZone", "DeskLamp7RunFast22", "ReadBook4", "CodeLife1", "FastLane9", "JavaBean7", "CoderGirl", "PhoneCase", "TabletFun", "WatchTime2", "QuietTime4SneakyCat6", "PuppyPower", "TreeHouse", "SoftPillow", "BigChair2", "CoolBreeze", "SurfBoard", "IceCream8", "JuiceBox3", "ChillOutSmartGuy9", "HackThis1", "TryAgain4", "OnlineNow", "QuickTrip", "NiceWork3", "LongSleep2", "SpaceTime", "RoadTrip1", "ZooVisit7"
]

strong_passwords = [
    "L@pt0p^Sup3r!Secure", "T1m3!2#HackTh3W0rld", "Dun3@Arrakis*2025", "M0nkey$Pl@n3t!88", "S3cur3_Th1ngz_4Me!C@t$0nM@rs2024", "Th3$ky!IsN0tTh3L1mit", "K33p0ut!OfMy$ystem", "!Secure4Life_2025", "MyD@rk$0ul_13++No_M0r3_P@sswords!", "G0_Br34k_Th1s^Now", "#Hack_Me_1f_U_Can", "H0ldTh3D00r^!", "Big#Br@1n$$S3cur3Keyboard!Sm@sh2025", "!S3cr3t_D0n't_T3ll", "ThisP@ssw0rdHasSpaces!", "3rr0r_404_$@fe", "Winter!$N0W88!!LetM3!1nN0w!", "Wh@t_D0_Y0u_W@nt?", "Tr0ub4dor&$2024", "R3d$kY@N1ght*", "S0Long&Thanks4Fish$Monkey#Island42", "4R3_U_Entert@ined??", "Matrix_R3b00t$$", "W@tch_Me!Vanish^", "L0ck3d&L0@ded!GalaxyFar&F@stAway", "Dr@gns$!BreatheFire", "Passwords?WeDon'tNeed'em", "PleaseD0n'tHack_Me", "$h4dow$+LightI$ee_Y0u_2025!", "N0!Acc3ss4U", "NotMyR3@lP@ss", "S@f3++And$0und", "St@y_0ut#HackerTh3QuickBr0wn$Fox!", "H0p_0ver_Th3^Moon", "L0v3_My_3xtr4_Sp@c3", "IL0v3_My#H@ckT00ls", "Ev3n#B3tter_Th@n_Last!F0rTheW1n!!2024", "B3!C@refull_WhatULeak", "ThisIsMySafeWord@", "Hackers!GetOut$$", "DarkM0de_Only!N0!B0rder$Here", "Just$Try2GuessM3", "D0n'tSt3alMyCooki3s", "P@ssphr@se$-Are-Gr8!", "Expl0it@YourOwnRiskG0AwayN0w!2025", "Pa$$word$N3verW1n", "Wiresh@rk!Detect3d", "@pple+0rch@rd$Fun", "Br@1ns>BruteF0rceMyPasswordIsUnbreakable", "LongStr1ngOf$Madness!", "$paceJ@mp^R3venge", "C@llM3_@dmiral0fP@ssphrasesIDr1nk!2Much_C0ffee", "NeverG0nnaGiv3UUp*", "R3venge0fTh3P@ssphrases", "JustAnother$D@y1nCyber", "JumpHost++BypassCrypt0Kn1ght99!!", "My+L0ck+H@s+N0+Key", "IAmTh3Firew@ll", "M3m0ry_L34k$$Here", "Punch+Th3+P@cketPl3@$eD0n'tF0rceM3", "C@ntHackTh1s_99!", "Enigma!Machine$Reset", "C0mm@nd+N+C0nquer$", "StopRightThereCr1minalT3rminal++Secured", "Adm1nIsN0t@User", "K3yM@shing!ForDays", "JustKeepT@ping1t!", "R3sist4nc3!Is+Fut1leIAm+Th3+Root_Cause", "2MuchEntropyHere!", "Can'tCrackM3$Today", "This1sJustCrazy$$", "IHave42GoodReasons!Brut3Force!@Yo0w", "$o$M@ny_C@mp1ex!Lines", "OverclockM3Baby", "Reboot!4TheW1n", "LetMe!S1t3Down"
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