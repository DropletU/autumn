extends PlayerState

func enter():
	pass # Runs entering the state
	

func exit():
	pass # Runs when exiting the state
	

func physics_update(delta: float):
	var direction: = Input.get_vector("left", "right", "up", "down")
	if direction == Vector2.ZERO:
		transition.emit("IdleState")
		return
	player.velocity = direction*player.SPEED*delta
	player.move_and_slide()
	

func unhandled_input(_event: InputEvent):
	pass # Runs on the players _unhandled_input()
	
