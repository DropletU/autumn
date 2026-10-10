class_name HotBody2D extends NearbyArea2D

@onready var collider = $CollisionShape2D

@export var temperature: = 60.0

func _physics_process(_delta: float) -> void:
	if nearby:
		GameManager.set_temp(temperature)
	
