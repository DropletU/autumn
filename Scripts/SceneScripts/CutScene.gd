extends Node2D


@export var Lines = [
	"I've been in this cold decrepit mansion for a while now..",
	".. Is this the way?",
	".. it's getting cold... better go near the fire over there."
]

var CurrentIndex = -1
var bCanContinue = false

var active_tween: Tween


@export var NextScene = "res://Scenes/Worlds/Mansion/MainChamber.tscn"
@export var ending: bool = false

func _ready() -> void:
	await get_tree().process_frame
	%Label.visible_characters = 0
	await get_tree().process_frame
	bCanContinue = true
	PlayNextLine()
	
func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		if bCanContinue:
			PlayNextLine()
			

func PlayNextLine():
	if bCanContinue == false:
		return
	if active_tween and active_tween.is_valid():
		active_tween.kill()
	%Continue.visible = false
	%Label.visible_characters = 0
	CurrentIndex += 1
	bCanContinue = false
	if CurrentIndex > Lines.size() - 1:
		if not ending:
			await GameManager.enter_new_room(NextScene, Vector2(3167.0,-634.0), Color.WHITE, 1.2)
		else:
			await TransitionScreen.BeginTransition(1.2, Color.BLACK)
			get_tree().quit()
		return
	
	
	
	%Label.text = Lines[CurrentIndex]
	active_tween = get_tree().create_tween()
	active_tween.tween_property(%Label, "visible_characters", len(Lines[CurrentIndex]), 1.2)
	await active_tween.finished
	%Continue.visible = true
	bCanContinue = true
	
	
