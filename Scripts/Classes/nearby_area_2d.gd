class_name NearbyArea2D extends Area2D

var nearby: bool = false
@export var interactable: bool = false

var tick = preload("res://Art/DialogueTick.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	collision_mask = (1 << 0) | (1 << 1)
	var tick_instance = Sprite2D.new()
	tick_instance.texture = tick
	tick_instance.position += Vector2(0, -60)
	tick_instance.visible = false
	add_child(tick_instance)
	tick = tick_instance
	


func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("Player"):
		return
	nearby = true
	if interactable:
		tick.visible = true
	
	

func _on_body_exited(body: Node2D) -> void:
	if not body.is_in_group("Player"):
		return
	nearby = false
	if interactable:
		tick.visible = false
	
