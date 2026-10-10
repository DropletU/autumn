class_name HotBody2D extends Area2D

@onready var collider = $CollisionShape2D
var player_in_range: bool = false

@export var temperature: = 60.0

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	

func _physics_process(_delta: float) -> void:
	if player_in_range:
		GameManager.set_temp(temperature)
	

func _on_body_entered(body: Node2D):
	if body.is_in_group("Player"):
		player_in_range = true
	

func _on_body_exited(body: Node2D):
	if body.is_in_group("Player"):
		player_in_range = false
	
