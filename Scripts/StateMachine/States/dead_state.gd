extends PlayerState

@export var dead_duration: float = 1.0

func enter():
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
	
