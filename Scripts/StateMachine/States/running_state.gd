extends PlayerState

func enter():
	player.animation.speed_scale = 1.5
	player.animation.play("walk")
	

func exit():
	pass # Runs when exiting the state
	

func physics_update(delta: float):
	var direction: = Input.get_vector("left", "right", "up", "down")
	if direction == Vector2.ZERO:
		transition.emit("IdleState")
		return
	if direction.x > 0 and player.animation.flip_h:
		player.animation.flip_h = false
	elif direction.x < 0 and not player.animation.flip_h:
		player.animation.flip_h = true
	player.velocity = direction*player.speed*delta*2
	player.move_and_slide()
	

func unhandled_input(event: InputEvent):
	if event.is_action_released("sprint"):
		transition.emit("WalkingState")
	
