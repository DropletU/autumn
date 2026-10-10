extends Node

var player: Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	

func heal_player(health: float):
	player.heal_player(health)
	

func player_health():
	return player.get_health()
	

func player_max_health():
	return player.get_max_health()

func enter_new_room(scene: String, new_pos: Vector2, fadeColor: Color = Color.BLACK, inTime: float = 0.5, outTime: float = 0.5):
	if TransitionScreen.bTransitioning:
		push_warning("Attempted to transition to scene " + scene + " while already transitioning.")
		return
	var packed_scene: PackedScene = load(scene)
	
	await TransitionScreen.BeginTransition(inTime, fadeColor)
	get_tree().change_scene_to_packed(packed_scene)
	
	await get_tree().scene_changed
	if not get_tree().current_scene.has_node("Player"):
		get_tree().current_scene.add_child(player)
	player.global_position = new_pos
	
	await TransitionScreen.EndTransition(outTime)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
