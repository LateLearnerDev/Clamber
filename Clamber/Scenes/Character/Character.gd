class_name Character
extends KinematicBody2D

export var is_facing_right := true

var _is_jumping := false
var _velocity := Vector2.ZERO
onready var sprite := $Sprite as Sprite


func _physics_process(_delta: float) -> void:
	var snap := Vector2.DOWN * 4 if !_is_jumping else Vector2.ZERO
	_velocity = move_and_slide_with_snap(_velocity, snap, Vector2.UP)
	_velocity.y += 10
	

func move_x(speed: float, max_speed: float) -> void:
	_velocity.x += speed
	_velocity.x = clamp(_velocity.x, -max_speed, max_speed)
	sprite.flip_h = speed < 0	
		
func stop_x(friction: float, air_resistance: float) -> void:
	if is_on_floor():	
		_velocity.x = lerp(_velocity.x, 0, friction)
	else:
		_velocity.x = lerp(_velocity.x, 0, air_resistance)
	
		
func jump_ascend(jump_force: float) -> void:
	if is_on_floor():
		_velocity.y += jump_force
		_is_jumping = true
		
func fall(jump_force: float) -> void:
	if !is_on_floor() and _velocity.y < jump_force/2:
		_is_jumping = false
		_velocity.y = jump_force/2
	

func use_rocket_pack(rocket_pack_boost: int, max_y_speed: int) -> void:
	_is_jumping = true
	_velocity.y += rocket_pack_boost
	_velocity.y = clamp(_velocity.y, max_y_speed, -max_y_speed)


func hang(direction: float) -> void:
	_velocity.y = 0
	if direction == 0:
		_velocity.x = 0
	else:	
		sprite.flip_h = direction < 0


func is_running_max_speed(max_x_speed: int) -> bool:
	return _velocity.x == max_x_speed or _velocity.x == -max_x_speed
	
func get_is_facing_right() -> bool:
	return is_facing_right
	
func set_is_facing_right(value: bool) -> void:
	is_facing_right = value
	
func get_is_jumping() -> bool:
	return _is_jumping




