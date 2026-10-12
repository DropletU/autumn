extends CanvasLayer

@export_range(0.0, 1.0) var lerp_strength: float = 1.0
@onready var progress_bar = $PanelContainer/ProgressBar

func _ready() -> void:
	await get_tree().process_frame
	progress_bar.value = GameManager.player_health()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	var player_health_percent: float = GameManager.player_health() / GameManager.player_max_health()
	progress_bar.value = player_health_percent*100
	progress_bar.modulate = lerp(Color.BLUE, Color.ORANGE, player_health_percent)
