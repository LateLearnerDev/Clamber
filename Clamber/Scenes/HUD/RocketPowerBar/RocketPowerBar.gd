class_name RocketPowerBar
extends Control

export var bar_max := 200

onready var texture_progress := $TextureProgress as TextureProgress

func _ready() -> void:
	hide()
	texture_progress.max_value = bar_max
	texture_progress.value = bar_max
#	var rocket_powers := get_tree().get_nodes_in_group('RocketPowers') as Array
#	print(rocket_powers.size())
#	for power in rocket_powers:		
#		var error = power.connect("rocket_power_collected", self, "_rocket_power_restore")
#		if error:
#			print(error)

func set_current_value(value: int) -> void:
	texture_progress.value = value
	
func set_max_value(value: int) -> void:
	texture_progress.max_value = value



