class_name RocketPowerBar
extends Control

export var bar_max := 200

onready var texture_progress := $TextureProgress as TextureProgress

func _ready() -> void:
	hide()
	texture_progress.max_value = bar_max
	texture_progress.value = bar_max

func set_current_value(value: int) -> void:
	texture_progress.value = value
	
func set_max_value(value: int) -> void:
	texture_progress.max_value = value



