class_name PlayerCam
extends Camera2D

export (float) var lerp_weight = 0.04
export (float) var max_y = -600

var initial_y: float
var current_x: float = 0.0

func _ready() -> void:
	global_position = Vector2.ZERO
	initial_y = position.y


func _physics_process(_delta: float) -> void:
	_move_to_x(current_x)


func move(position_to_follow: Vector2):
	position.y = clamp(lerp(position - Vector2(0,10.5), position_to_follow, lerp_weight).y, initial_y+max_y, -400)
	

func set_current_x(x: float):
	current_x += x
	
func _move_to_x(x: float):
	position.x = lerp(position.x, x, lerp_weight * 2)
	
	
