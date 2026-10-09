class_name Player extends CharacterBody2D


var respawn_point: Vector2

@export var speed = 6000.0

@export var state_machine: StateMachine
@export var health_component: HealthComponent

func _ready() -> void:
	GameManager.player = self
	z_index = 1
	respawn_point = global_position

func _physics_process(delta: float) -> void:
	state_machine.physics_update(delta)
	

func _unhandled_input(event: InputEvent) -> void:
	state_machine.unhandled_input(event)


func respawn(respawn_pos: Vector2 = respawn_point):
	global_position = respawn_pos
	

func set_respawn_point(new_respawn_point: Vector2):
	respawn_point = new_respawn_point
	

func heal_player(health: float):
	health_component.heal(health)
	

func get_health():
	return health_component.get_health()
	

func get_max_health():
	return health_component.get_max_health()
	
