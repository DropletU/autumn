extends Node2D


var Lines = [
	"I've been in this cold decrepit mansion for a while now..",
	".. Is this the way?",
	".. it's getting cold... better go near the fire over there."
]

var CurrentIndex = -1
var bCanContinue = true

func _ready() -> void:
	%Label.visible_characters = 0
	PlayNextLine()
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		if bCanContinue:
			PlayNextLine()
			
func PlayNextLine():
	if bCanContinue == false:
		return
	%Continue.visible = false
	%Label.visible_characters = 0
	CurrentIndex += 1
	bCanContinue = false
	if CurrentIndex > Lines.size() - 1:
		%AnimationPlayer.play("anim")
		await %AnimationPlayer.animation_finished
		get_tree().change_scene_to_file("res://Scenes/main.tscn")
		return
	
	
	%Label.text = Lines[CurrentIndex]
	var tween = get_tree().create_tween()
	tween.tween_property(%Label, "visible_characters", len(Lines[CurrentIndex]), 1.2)
	await tween.finished
	%Continue.visible = true
	bCanContinue = true
	
	
