extends CharacterBody2D


const SPEED = 6000.0

var respawn_point: Vector2

@export var state_machine: StateMachine

func _ready() -> void:
	respawn_point = global_position

func _physics_process(delta: float) -> void:
	state_machine.physics_update(delta)
	

func _unhandled_input(event: InputEvent) -> void:
	state_machine.unhandled_input(event)


func respawn(respawn_pos: Vector2 = respawn_point):
	global_position = respawn_pos
	
