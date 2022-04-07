class_name RocketPack
extends Collectable

const THRUST_POWER = -100
const COST = 1
const RECHARGE_RATE = 1
const MAX_ENERGY = 200

var _current_energy: int = MAX_ENERGY 

onready var sprite := $Sprite as Sprite

func _ready() -> void:
	pass 
	
func collected() -> void:
	sprite.queue_free()
	set_deferred("monitorable", false)

func set_current_energy(value: int) -> void:
	_current_energy = value
	
func get_current_energy() -> int:
	return _current_energy	
	
	
func consume_energy() -> void:
	_current_energy -= COST
	
func increase_energy() -> void:
	if _current_energy < MAX_ENERGY:
		_current_energy += RECHARGE_RATE
	
	
func is_empty() -> bool:
	return _current_energy <= 0
	



