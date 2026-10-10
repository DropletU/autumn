class_name TemperatureComponent extends Node

@export_range(0.0, 100.0) var current_temperature: float = 30.0
@export var cold_point: float = 40.0
var feeling_cold: bool = false
var area_temperature: float = 30.0

func _physics_process(delta: float) -> void:
	current_temperature = lerp(current_temperature, area_temperature, 0.7*delta)
	if current_temperature <= cold_point:
		feeling_cold = true
	else:
		feeling_cold = false
	

func change_area_temperature(new_temp):
	area_temperature = new_temp
	

func get_healing():
	return (current_temperature-cold_point)*get_physics_process_delta_time()
	

func get_freeze_damage():
	return (cold_point-current_temperature)*get_physics_process_delta_time()
	

func get_freezing():
	return feeling_cold
	
