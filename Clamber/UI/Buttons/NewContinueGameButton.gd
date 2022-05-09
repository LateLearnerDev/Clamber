extends Button

export (PackedScene) var level_path

func _ready() -> void:
	pass


func _on_NewContinueGameButton_pressed() -> void:
	var error = get_tree().change_scene_to(level_path)
	if error:
		print(error)
