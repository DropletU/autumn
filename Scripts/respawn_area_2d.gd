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
	var number_of_markers: int = 0
	for child in get_children():
		if child is Marker2D:
			number_of_markers+=1
	if number_of_markers == 0:
		return ["This node has no marker, so it does not know where to set its respawn point.
		Consider adding a Marker2D as a child to define its respawn position."]
	elif number_of_markers > 1:
		return ["This node has more than one marker, so it does not know which one to use as its respawn point.
		Unless a custom script is written, the last marker in the tree will be used for the respawn position.
		Consider having only one Marker2D child to avoid confusion when setting the respawn position."]
	return []
	
