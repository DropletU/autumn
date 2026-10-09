extends PlayerState

func enter():
	player.velocity = Vector2.ZERO
	

func exit():
	pass # Runs when exiting the state
	

func physics_update(_delta: float):
	if Input.get_vector("left", "right", "up", "down"):
		transition.emit("MovingState")
	

func unhandled_input(_event: InputEvent):
	pass # Runs on the players _unhandled_input()
	
