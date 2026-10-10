extends Control

var bTransitioning = false

func _ready() -> void:
	%Panel.modulate = Color.BLACK
	FadeOut(1.2)
	
func MoveToScene(scene, fadeColor: Color = Color.BLACK, inTime: float = 0.5, outTime: float = 0.5):
	if bTransitioning:
		return
	bTransitioning = true
	await FadeToColor(fadeColor, inTime)
	get_tree().change_scene_to_file(scene)
	await FadeOut(outTime)
	bTransitioning = false
	
func FadeToColor(fadeColor, inTime):
	var tween = get_tree().create_tween()
	tween.tween_property(%Panel, "modulate", fadeColor, inTime)
	await tween.finished
	
func FadeOut(outTime):
	FadeToColor(Color(0,0,0,0), outTime)
	
