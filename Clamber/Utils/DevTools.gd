extends Node

func _ready() -> void:
	if !OS.is_debug_build():
		set_process(false)
	

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("restart_level"):
		var error := get_tree().reload_current_scene()
		if error:
			print(error)
