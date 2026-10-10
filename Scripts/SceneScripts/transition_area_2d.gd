class_name TransitionArea2D extends NearbyArea2D


@export var transition_to: String
@export var transition_pos: Vector2
@export_group("Transition Effects")
@export var fade_to: Color = Color.BLACK
@export var inTime: float = 1.0
@export var outTime: float = 1.0

func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		GameManager.enter_new_room(transition_to, transition_pos, fade_to, inTime, outTime)
	
