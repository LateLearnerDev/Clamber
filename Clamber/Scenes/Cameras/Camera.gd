class_name PlayerCam
extends Camera2D

export (float) var lerp_weight = 0.04
export (float) var max_y = -800

var initial_y: float

func _ready() -> void:
	global_position = Vector2.ZERO
	initial_y = position.y


func move(position_to_follow: Vector2):
	position.y = clamp(lerp(position - Vector2(0,10.5), position_to_follow, lerp_weight).y, initial_y+max_y, -400)
	
	
func set_position(position: Vector2):
	pass
	
	
