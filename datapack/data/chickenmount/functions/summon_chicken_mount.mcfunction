# Called by player to summon and ride a personal chicken mount

tag @s add cm.caller
execute store result score @s cm_pid run data get entity @s UUID[0]

# Remove existing mount owned by caller
execute as @e[type=chicken,tag=cm.mount] if score @s cm_pid = @a[tag=cm.caller,limit=1] cm_pid run kill @s

# Cache owner UUID in storage
data modify storage chickenmount:temp owner set from entity @s UUID

# Summon enhanced chicken
summon minecraft:chicken ~ ~ ~ {Tags:["cm.mount","cm.new"],Attributes:[{Name:"minecraft:generic.max_health",Base:40.0f},{Name:"minecraft:generic.movement_speed",Base:0.35f},{Name:"minecraft:generic.knockback_resistance",Base:0.5f}],Health:40.0f,PersistenceRequired:1b}

# Link ownership metadata and reset cleanup timer
execute as @e[tag=cm.new,limit=1,sort=nearest] run scoreboard players operation @s cm_pid = @a[tag=cm.caller,limit=1] cm_pid
execute store result entity @e[tag=cm.new,limit=1,sort=nearest] custom_data.owner[0] int 1 run data get storage chickenmount:temp owner[0]
execute store result entity @e[tag=cm.new,limit=1,sort=nearest] custom_data.owner[1] int 1 run data get storage chickenmount:temp owner[1]
execute store result entity @e[tag=cm.new,limit=1,sort=nearest] custom_data.owner[2] int 1 run data get storage chickenmount:temp owner[2]
execute store result entity @e[tag=cm.new,limit=1,sort=nearest] custom_data.owner[3] int 1 run data get storage chickenmount:temp owner[3]
scoreboard players set @e[tag=cm.new] cm_clean 0

# Mount the player
ride @a[tag=cm.caller,limit=1] mount @e[tag=cm.new,limit=1,sort=nearest]

tag @e[tag=cm.new] remove cm.new
tag @a[tag=cm.caller] remove cm.caller
