class_name Player extends CharacterBody2D


var respawn_point: Vector2

@export var speed = 12000.0

@export var state_machine: StateMachine
@export var health_component: HealthComponent

var bIsDead = false

func _ready() -> void:
	GameManager.player = self
	z_index = 1
	respawn_point = global_position
	

func _physics_process(delta: float) -> void:
	state_machine.physics_update(delta)
	
	if bIsDead == false:
		if Input.is_action_just_pressed("sprint"):
			bIsDead = true
		if Input.is_action_pressed("left"):
			$AnimatedSprite2D.scale = Vector2(-1,1)
		elif Input.is_action_pressed("right"):
			$AnimatedSprite2D.scale = Vector2.ONE
		if Input.is_anything_pressed():
			$AnimatedSprite2D.play("walk")
		else:
			$AnimatedSprite2D.play("default")
	else:
		$AnimatedSprite2D.play("death")
	

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
	
