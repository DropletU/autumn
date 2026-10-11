class_name Player extends CharacterBody2D


var respawn_point: Vector2

@export var speed = 12000.0

@export var key_held: bool = false
@export var state_machine: StateMachine
@export var health_component: HealthComponent
@onready var animation: AnimatedSprite2D = $AnimatedSprite2D
@onready var temperature_component: TemperatureComponent = $TemperatureComponent

func _ready() -> void:
	GameManager.player = self
	z_index = 1
	respawn_point = global_position
	health_component.died.connect(_on_died)
	

func _enter_tree() -> void:
	if key_held:
		get_node("Key2D").global_position = $HeldObjectPosition
	

func _physics_process(delta: float) -> void:
	state_machine.physics_update(delta)
	if not health_component.is_alive():
		return
	if temperature_component.get_freezing():
		health_component.take_damage(temperature_component.get_freeze_damage())
	else:
		health_component.heal(temperature_component.get_healing())
	

func _unhandled_input(event: InputEvent) -> void:
	state_machine.unhandled_input(event)


func respawn(respawn_pos: Vector2 = respawn_point):
	health_component.revive()
	global_position = respawn_pos
	

func set_respawn_point(new_respawn_point: Vector2):
	respawn_point = new_respawn_point
	

func heal_player(health: float):
	health_component.heal(health)
	

func get_health():
	return health_component.get_health()
	

func get_max_health():
	return health_component.get_max_health()
	

func _on_died(attacker: HitBox2D = null):
	state_machine.transition_to("DeadState", [attacker])
	
