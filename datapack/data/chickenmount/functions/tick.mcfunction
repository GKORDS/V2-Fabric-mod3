# Cleanup orphaned mounts
execute as @e[type=chicken,tag=cm.mount] if entity @s[nbt={Passengers:[]}] run scoreboard players add @s cm_clean 1
execute as @e[type=chicken,tag=cm.mount] unless entity @s[nbt={Passengers:[]}] run scoreboard players set @s cm_clean 0
execute as @e[type=chicken,tag=cm.mount,scores={cm_clean=200..}] run kill @s
