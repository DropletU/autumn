class_name HealthComponent extends Node
## A component that can be added to any [Node] to give
## it a simple health system. 
##
## This class holds a [member _hp] variable and a
## [member _max_hp] variable. They can be forcefully
## set through [method set_health] and [method set_max_health]. [br]
## You can also use [method take_damage] if the [Node]
## was attacked, and [method heal] is it was healed.
## Note that [member _hp] will never be below [code]0[/code]
## or above [member _max_hp]. [br][br]
## Every time [member _hp] is changed, it will emit a 
## signal called [signal health_changed], as well
## as a signal based on where it changed from, like
## [signal health_set] or [signal damaged]. [br]
## If [member _hp] ever reaches [code]0[/code], then
## [signal died] will emit. Once it emits, most methods
## affecting [member _hp] will immediately fail.


## The current health. Use [method get_health] to check
## this value
@export_range(1, 1000) var _hp: float = 100
## The current max health. Use [method get_max_health]
## to check this value
@export_range(1, 1000) var _max_hp: float = 100


var _alive: = true

## Emits when damage is taken
signal damaged(damage: float, current_health: float, attacker: Node2D)
## Emits when healed
signal healed(health: float, current_health: float)
## Emits when [member _hp] is forcefully set
signal health_set(health: float)
## Emits when [member _max_hp] is forcefully set
signal max_health_changed(max_health: float)
## Emits when [member _hp] reaches 0
signal died
## Emits when the player is revived
signal revived
## Emits any time [member _hp] is changed
signal health_changed(new_hp: float)

func _ready() -> void:
	if _hp > _max_hp:
		_change_health(minf(_hp, _max_hp))
	

func _change_health(new_health: float) -> void:
	if not is_alive():
		return
	_hp = new_health
	health_changed.emit(new_health)
	

## Force sets [member _max_hp] to any value greater than
## or equal to [code]1[/code]
func set_max_health(amount: float) -> void:
	var new_max_hp = maxf(1, amount)
	if new_max_hp == _max_hp:
		return
	_max_hp = new_max_hp
	max_health_changed.emit(_max_hp)
	
	if _max_hp<_hp:
		set_health(_max_hp)
	

## Force sets [member _hp] to any value between
## [code]0[/code] and [member _max_hp]
func set_health(amount: float) -> void:
	if not is_alive():
		return
	var new_hp = clampf(amount, 0, _max_hp)
	if _hp==new_hp:
		return
	
	_change_health(new_hp)
	health_set.emit(_hp)
	
	if _hp == 0:
		_died()
	

## Damages the entity for [member damage] damage. 
## If [member damage] is greater than [member _hp],
## then [member _hp] will be set to [code]0[/code]
func take_damage(damage: float, attacker: Node2D = null) -> void:
	if not is_alive():
		return
	if damage <= 0:
		return
	
	damage = minf(damage, _hp)
	_change_health(_hp-damage)
	damaged.emit(damage, _hp, attacker)
	
	if _hp == 0:
		_died()
	

## Heals the entity for [member health] health.
## If [member health] is greater than [member _max_hp],
## then [member _hp] will be set to [member _max_hp]
func heal(health: float) -> void:
	if not is_alive():
		return
	if health<=0:
		return
	if _hp==_max_hp:
		return
	
	health = minf(_max_hp-_hp, health)
	_change_health(_hp+health)
	healed.emit(health, _hp)
	

func _died() -> void:
	if not is_alive():
		return
	
	_alive = false
	died.emit()
	

func revive():
	if is_alive():
		return
	
	_alive = true
	revived.emit()
	

## Returns [member _hp]
func get_health() -> float:
	return _hp
	

## Returns [member _max_hp]
func get_max_health() -> float:
	return _max_hp
	

## Returns [member _alive]
func is_alive() -> bool:
	return _alive
	
