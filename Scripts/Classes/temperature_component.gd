class_name TemperatureComponent extends Node

@export_range(0.0, 100.0) var current_temperature: float = 100.0
var area_temperature: float = 30.0

func _physics_process(delta: float) -> void:
	current_temperature = lerp(current_temperature, area_temperature, 0.5*delta)
	

func change_area_temperature(new_temp):
	area_temperature = new_temp
	
