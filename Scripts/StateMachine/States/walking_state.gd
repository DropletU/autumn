extends PlayerState

var footstep_delay: float = 0.35
var footstep_timer: float = 0.0

func enter(_args: Array):
	player.animation.speed_scale = 1
	player.animation.play("walk")
	

func exit():
	footstep_timer = 0.0
	

func physics_update(delta: float):
	var direction: = Input.get_vector("left", "right", "up", "down")
	if direction == Vector2.ZERO:
		transition.emit("IdleState")
		return
	if direction.x > 0 and player.animation.flip_h:
		player.animation.flip_h = false
	elif direction.x < 0 and not player.animation.flip_h:
		player.animation.flip_h = true
	player.velocity = direction*player.speed*delta
	player.move_and_slide()
	footstep_timer+=delta
	if footstep_timer >= footstep_delay:
		pass
		# Play Audio Here: Footstep Audio
		
	

func unhandled_input(event: InputEvent):
	if event.is_action_pressed("sprint"):
		transition.emit("RunningState")
	
