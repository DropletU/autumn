extends Area2D

@onready var collider = $CollisionShape2D
var heal_player: bool = false

@export var heal_per_sec: float = 5.0

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	

func _physics_process(delta: float) -> void:
	if not heal_player:
		return
	GameManager.heal_player(heal_per_sec*delta)
	if GameManager.player_health() >= GameManager.player_max_health():
		heal_player = false
	

func _on_body_entered(body: Node2D):
	if body.is_in_group("Player"):
		heal_player = true
	

func _on_body_exited(body: Node2D):
	if body.is_in_group("Player"):
		heal_player = false
	
