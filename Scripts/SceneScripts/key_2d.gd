extends NearbyArea2D

var marker_position: Marker2D
## Follow strength used in lerp() before delta
@export_range(0.0, 10.0) var follow_strength: float = 10.0

@warning_ignore("unused_signal")
signal key_used

func _unhandled_key_input(event: InputEvent) -> void:
	if not nearby:
		return
	if event.is_action_pressed("interact"):
		marker_position = GameManager.player.get_node("HeldObjectPosition")
		GameManager.player.key_held = true
		reparent(GameManager.player)
		z_index = 2
	

func _physics_process(delta: float) -> void:
	if not marker_position:
		return
	scale = lerp(scale, Vector2(0.7, 0.7), 0.2)
	global_position = lerp(global_position, marker_position.global_position, follow_strength*delta)
	
