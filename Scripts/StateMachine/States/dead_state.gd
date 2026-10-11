extends PlayerState

@export var dead_duration: float = 1.0

@onready var splatter_textures: Array = [
	preload("res://Art/BloodSplatter/BloodSplatter1.png"),
	preload("res://Art/BloodSplatter/BloodSplatter2.png")
]
var attacker: Node2D

func enter(args: Array):
	if args[0] is HitBox2D:
		attacker = args[0]
		if (attacker as HitBox2D).cause_splatter:
			var blood_splatter = Sprite2D.new()
			blood_splatter.texture = splatter_textures.pick_random()
			blood_splatter.global_position = player.global_position + Vector2(0, 40)
			get_tree().current_scene.add_child(blood_splatter)
	
	# Play Audio Here: Died Audio
	
	player.velocity = Vector2.ZERO
	player.animation.play("death")
	await player.animation.animation_finished
	player.respawn()
	transition.emit("IdleState")
	

func exit():
	pass
	

func physics_update(_delta: float):
	return
	

func unhandled_input(_event: InputEvent):
	pass # Runs on the players _unhandled_input()
	
