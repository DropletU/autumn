class_name StateMachine extends Node

@export var player: CharacterBody2D = get_parent()
@export var initial_state: PlayerState
var current_state: PlayerState

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		child.player = player
		child.transition.connect(transition_to)
	

func physics_update(delta: float) -> void:
	current_state.physics_update(delta)
	

func unhandled_input(event: InputEvent) -> void:
	current_state.unhandled_input(event)
	

func transition_to(state_name: String):
	var new_state = get_node_or_null(state_name)
	if new_state == null or new_state == current_state:
		return
	current_state.exit()
	current_state = new_state
	new_state.enter()
	
