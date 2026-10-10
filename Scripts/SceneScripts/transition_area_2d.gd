class_name TransitionArea2D extends Area2D

var nearby: bool = false

@export var transition_to: String
@export var transition_pos: Vector2
@export_group("Transition Effects")
@export var fade_to: Color = Color.BLACK
@export var inTime: float = 1.0
@export var outTime: float = 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	

func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		GameManager.enter_new_room(transition_to, transition_pos, fade_to, inTime, outTime)
	

func _on_body_entered(body: Node2D):
	if body.is_in_group("Player"):
		nearby = true
	

func _on_body_exited(body: Node2D):
	if body.is_in_group("Player"):
		nearby = false
	
