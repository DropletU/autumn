extends PlayerState

@export var dead_duration: float = 1.0
var dead_time: = 0.0

func enter():
	player.velocity = Vector2.ZERO
	

func exit():
	dead_time = 0.0
	

func physics_update(delta: float):
	dead_time+=delta
	if dead_time < dead_duration:
		return
	
	player.respawn()
	if Input.get_vector("left", "right", "up", "down"):
		transition.emit("MovingState")
	transition.emit("IdleState")
	

func unhandled_input(_event: InputEvent):
	pass # Runs on the players _unhandled_input()
	
