class_name TransitionArea2D extends NearbyArea2D


var door = load("res://Art/DoorFront.png")

@export var active: bool = true
## Must be the full name from after Worlds in the file system. [br]
## For example, if you want the MainChamber, you write: [br]
## /Mansion/MainChamber.tscn
@export var transition_to: String
@export var transition_pos: Vector2
## Change this value to a unique number if this [TransitionArea2D] has something
## unique about it
@export var uid: = 0
@export_group("Transition Effects")
@export var fade_to: Color = Color.BLACK
@export var inTime: float = 1.0
@export var outTime: float = 1.0
@export var audio: AudioStreamMP3
@export var unlock_audio: AudioStreamMP3

signal activated(id_number: int)

func _ready() -> void:
	super._ready()
	activated.connect(GameManager._on_transitioner_activated)
	if uid in GameManager.unlocked_transitioners:
		active = true
	

func _unhandled_key_input(event: InputEvent) -> void:
	if not nearby:
		return
	if event.is_action_pressed("interact", false):
		if not active:
			if GameManager.keys_held:
				active = true
				GameManager.keys_held -= 1
				# Play Audio Here: Unlock Audio
				get_parent().texture = door
				activated.emit(uid)
			return
		# Play Audio Here: Play [member audio]
		GameManager.enter_new_room(transition_to, transition_pos, fade_to, inTime, outTime)
	
