@tool

class_name RespawnArea2D extends Area2D

var respawn_point: Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	child_entered_tree.connect(_on_child_entered)
	child_exiting_tree.connect(_on_child_exiting)
	body_entered.connect(_on_body_entered)
	for child in get_children():
		if child is Marker2D:
			respawn_point = child.global_position
	

func _on_child_entered(node: Node):
	if node is Marker2D:
		update_configuration_warnings()
	

func _on_child_exiting(node: Node):
	if node is Marker2D:
		update_configuration_warnings()
	

func _on_body_entered(body: Node2D):
	if body.is_in_group("Player"):
		body.set_respawn_point(respawn_point)
	

func _get_configuration_warnings() -> PackedStringArray:
	if not respawn_marker:
		return ["This node has no marker, so it does not know where to set its respawn point.
		Consider adding a Marker2D as a child to define its respawn position."]
	return []
	
