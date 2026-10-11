extends HitBox2D

@export var hits_per_second: float = 1.0

func _on_area_entered(area: Area2D):
	super._on_area_entered(area)
	await get_tree().create_timer(1.0/hits_per_second).timeout
	set_deferred("monitoring", true)
	
