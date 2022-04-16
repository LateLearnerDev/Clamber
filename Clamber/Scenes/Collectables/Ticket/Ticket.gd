class_name Ticket
extends Collectable

onready var sprite := $Sprite as Sprite

func collected() -> void:
	sprite.visible = false
	set_deferred("monitorable", false)
