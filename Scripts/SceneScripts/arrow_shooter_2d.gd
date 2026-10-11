@tool
extends NearbyArea2D

var shot: bool = false
var arrow = preload("res://Scenes/arrow_2d.tscn")

@export var shoot_strength: float = 1000.0
@export_range(1.0, 100.0) var damage: float = 10
@export var cause_splatter: bool = true

func _ready() -> void:
	super._ready()
	if Engine.is_editor_hint():
		$Spike.visible = true
	else:
		$Spike.visible = false
	

func _on_body_entered(body: Node2D) -> void:
	if shot:
		return
	if Engine.is_editor_hint():
		return
	if not body.is_in_group("Player"):
		return
	
	# Play Audio Here: Arrow Shooting
	
	shot = true
	var arrow_instance = arrow.instantiate() as RigidBody2D
	arrow_instance.set_deferred("global_rotation", global_rotation)
	arrow_instance.set_deferred("global_position", global_position)
	arrow_instance.set_deferred("shoot_strength", shoot_strength)
	arrow_instance.set_deferred("damage", damage)
	arrow_instance.set_deferred("cause_splatter", cause_splatter)
	get_tree().current_scene.call_deferred("add_child", arrow_instance)
	
	
