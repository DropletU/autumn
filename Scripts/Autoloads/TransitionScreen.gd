extends Control

var bTransitioning = false

func _ready() -> void:
	%Panel.modulate = Color.TRANSPARENT
	EndTransition(1.2)
	

func BeginTransition(inTime: = 1.0, fadeColor: Color = Color.BLACK):
	bTransitioning = true
	var tween = get_tree().create_tween()
	tween.tween_property(%Panel, "modulate", fadeColor, inTime)
	await tween.finished
	
func EndTransition(outTime: = 1.0, fadeColor: Color = Color.TRANSPARENT):
	var tween = get_tree().create_tween()
	tween.tween_property(%Panel, "modulate", fadeColor, outTime)
	await tween.finished
	bTransitioning = false
	
