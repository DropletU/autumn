extends CharacterBody2D


const SPEED = 6000.0

@export var state_machine: StateMachine

func _physics_process(delta: float) -> void:
	state_machine.physics_update(delta)
	

func _unhandled_input(event: InputEvent) -> void:
	state_machine.unhandled_input(event)
