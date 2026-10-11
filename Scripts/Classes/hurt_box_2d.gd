class_name HurtBox2D extends Area2D

var player: Player

func _ready() -> void:
	collision_mask = 0
	collision_layer = 1 << 1
	player = get_parent() if get_parent() is Player else null
	


func take_damage(damage: float, attacker: HitBox2D):
	player.health_component.take_damage(damage, attacker)
	
