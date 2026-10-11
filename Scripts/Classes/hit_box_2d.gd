class_name HitBox2D extends Area2D
## A hitbox that can be used to make traps and attacks.
##
## If you want it to also cause blood splatter on the floor, you can enable
## [member cause_splatter] in the inspector. 

## The damage the player will take. Keep in mind the players health
## when setting this. 
@export_range(0.0, 100.0) var damage: float = 10.0
@export var cause_splatter: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	collision_layer = 0
	collision_mask = 1 << 1
	area_entered.connect(_on_area_entered)
	

func _on_area_entered(area: Area2D):
	if area is not HurtBox2D:
		return
	set_deferred("monitoring", false)
	area = area as HurtBox2D
	area.take_damage(damage, self)
	
