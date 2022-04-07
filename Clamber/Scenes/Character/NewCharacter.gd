class_name NewCharacter
extends KinematicBody2D

signal rocket_pack_used
signal reached_max_x_speed

const MAX_X_SPEED: int = 100
const MAX_Y_SPEED: int = -100
const JUMP_FORCE: float = -275.0
const ACCELERATION: int = 5
const FRICTION: float = 0.8
const AIR_RESISTANCE: float = 0.02
#const ShootBlockPath = preload("res://Scenes/ShootBlock.tscn")

export var jump_enabled: bool = true

var _jump_ref: FuncRef = null
var _use_rocket_pack_ref: FuncRef = null
var _use_block_gun_ref: FuncRef = null

var is_hanging := false
var _is_jumping := false
var _x_direction: float
var _velocity := Vector2.ZERO
var _shoot_spawn_x: float
var _block_gun_equipped := false
var _rocket_pack_equipped := false
var _rocket_pack_active := false
var _rocket_pack_empty := false
var _run_animation_name := "Run"
var _idle_animation_name := "Idle"
var _jump_animation_name := "Jump"
var _hang_idle_animation_name := "HangIdle"
var _hang_move_animation_name := "HangMove"
onready var sprite := $Sprite as Sprite
#onready var animation_player := $AnimationPlayer as AnimationPlayer
onready var shoot_block_spawn_position := $ShootSpawnPos as Position2D
onready var shoot_check_area := $ShootCheckArea as Area2D

#func _ready() -> void:
#	_jump_ref = _setup_jump()
#	_use_rocket_pack_ref = funcref(self, "_disabled_rocket_pack")
#	_use_block_gun_ref = funcref(self, "_disabled_block_gun")
#	_shoot_spawn_x = shoot_block_spawn_position.position.x


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
		
	
func fall(jump_force: float) -> void:
	if !is_on_floor() and _velocity.y < JUMP_FORCE/2:
		_velocity.y = jump_force/2
	
	
func use_rocket_pack(rocket_pack_boost: int, max_y_speed: int) -> void:
	_is_jumping = true
	_rocket_pack_active = true	
	emit_signal("rocket_pack_used")		
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
		
	
func _handle_input_movement() -> void:	
	if Input.is_action_just_pressed("ui_right"):
		shoot_block_spawn_position.position.x = _shoot_spawn_x
		shoot_check_area.position.x = _shoot_spawn_x
	if Input.is_action_just_pressed("ui_left"):
		shoot_block_spawn_position.position.x = -_shoot_spawn_x
		shoot_check_area.position.x = -_shoot_spawn_x
	
	
func _on_RocketPack_rocket_pack_collected() -> void:
	_rocket_pack_equipped = true
	_run_animation_name = "RocketRun"
	_idle_animation_name = "RocketIdle"
	_jump_animation_name = "RocketJump"
	_hang_idle_animation_name = "HangRocketIdle"
	_hang_move_animation_name = "HangRocketMove"
	_use_rocket_pack_ref = funcref(self, "_rocket_pack")	

func _on_BlockGun_block_gun_collected() -> void:
	_block_gun_equipped = true
	_use_block_gun_ref = funcref(self, "_shoot")
	
func _disabled_block_gun() -> void:
	pass

#func _shoot() -> void:
#	if !_can_shoot():
#		return
#
#	var shoot_blocks: Array = get_tree().get_nodes_in_group("ShootBlocks")
#	if shoot_blocks.size() >= 2:
#		return
#
#	var bullet: ShootBlock = ShootBlockPath.instance()
#	if sign(shoot_block_spawn_position.position.x) == Vector2.RIGHT.x:
#		bullet.set_direction(Vector2.RIGHT)
#	else:
#		bullet.set_direction(Vector2.LEFT)
#	get_parent().add_child(bullet)
#	bullet.transform = shoot_block_spawn_position.global_transform

func _can_shoot() -> bool:
	if shoot_check_area.get_overlapping_bodies().size() > 0:
		return false
	
	return true


