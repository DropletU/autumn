extends NearbyArea2D

var marker_position: Marker2D
## Follow strength used in lerp() before delta
@export_range(0.0, 10.0) var follow_strength: float = 10.0
## Make sure all keys have a unique uid. Note: These don't correlate to
## [TransitionArea2D]'s
@export var uid: int = 0

signal key_picked_up(id_number: int)

func _ready() -> void:
	super._ready()
	key_picked_up.connect(GameManager._on_key_picked_up)
	if uid in GameManager.keys_picked_up:
		queue_free()
	

func _unhandled_key_input(event: InputEvent) -> void:
	if not nearby:
		return
	if event.is_action_pressed("interact"):
		marker_position = GameManager.player.get_node("HeldObjectPosition")
		GameManager.keys_held += 1
		key_picked_up.emit(uid)
		z_index = 2
	

func _physics_process(delta: float) -> void:
	if not marker_position:
		return
	scale = lerp(scale, Vector2(0.7, 0.7), 0.2)
	global_position = lerp(global_position, marker_position.global_position, follow_strength*delta)
	if global_position.distance_to(marker_position.global_position) < Vector2.RIGHT.length()*5:
		queue_free()
	
