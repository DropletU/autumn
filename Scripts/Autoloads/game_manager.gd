extends Node

var player: Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func heal_player(health: float):
	player.heal_player(health)
	

func player_health():
	return player.get_health()
	

func player_max_health():
	return player.get_max_health()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
