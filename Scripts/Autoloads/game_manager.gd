extends Node

var player: Player

var temps_in_effect: PackedFloat32Array = []
var keys_held: int = 0
var unlocked_transitioners: PackedInt32Array = []
var keys_picked_up: PackedInt32Array = []
var player_temp: float
var player_hp: float = player.get_max_health() if player else 100.0

signal player_revived

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_physics_priority = 1
	

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
	if !ResourceLoader.exists(scene):
		scene = "res://Scenes/Worlds/" + scene
	assert(ResourceLoader.exists(scene), "Could not find scene: " + scene + " during scene transition!")
	var packed_scene: PackedScene = load(scene)
	
	await TransitionScreen.BeginTransition(inTime, fadeColor)
	get_tree().change_scene_to_packed(packed_scene)
	
	await get_tree().scene_changed
	if not get_tree().current_scene.has_node("Player"):
		if player:
			get_tree().current_scene.add_child(player)
	if player: player.global_position = new_pos
	
	await TransitionScreen.EndTransition(outTime)
	

func set_temp(temperature: float):
	temps_in_effect.append(temperature)
	

func _set_player_temp():
	if not player:
		return
	temps_in_effect.append(30.0)
	var new_temp: float = 0.0
	for temp in temps_in_effect:
		new_temp+=temp
	new_temp/=temps_in_effect.size()
	player_temp = new_temp
	temps_in_effect.clear()
	

func _on_transitioner_activated(id_number: int):
	if id_number not in unlocked_transitioners:
		unlocked_transitioners.append(id_number)
	else:
		push_warning("TransitionArea2D with ID: ", id_number, " was unlocked twice?
		Double check if this ID number is unique!")
	

func _on_key_picked_up(id_number: int):
	if id_number not in keys_picked_up:
		keys_picked_up.append(id_number)
	else:
		push_warning("Key2D with ID: ", id_number, " was picked up twice?
		Double check if this ID number is unique!")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	_set_player_temp()
	
