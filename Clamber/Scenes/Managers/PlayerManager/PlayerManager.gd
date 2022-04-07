class_name PlayerManager
extends Node2D

const MAX_X_SPEED: int = 100
const MAX_Y_SPEED: int = -100
const ACCELERATION: int = 5
const FRICTION: float = 0.8
const JUMP_FORCE: float = -275.0
const AIR_RESISTANCE: float = 0.02
const GRAVITY: float = 10.0

var _is_hanging := false setget set_is_hanging

onready var player_character := $NewCharacter as NewCharacter
onready var hang_check_area := $NewCharacter/HangCheckArea as HangCheckArea
onready var collectable_check_area := $NewCharacter/CollectableCheckArea as CollectableCheckArea
onready var character_animation := $NewCharacter/CharacterAnimation as CharacterAnimation
onready var hud := $HUD as Hud
var rocket_pack: RocketPack = null

func _ready() -> void:
	hang_check_area.connect("hang_collider_entered", self, "set_is_hanging", [true])
	hang_check_area.connect("hang_collider_exited", self, "set_is_hanging", [false])
	collectable_check_area.connect("rocket_pack_collected", self, "_equip_rocket_pack")


func _physics_process(delta: float) -> void:	
	var x_input := Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")	
	
	if player_character.is_on_floor():
		character_animation.set_ground_state()
		_increase_rocket_power_if_player_max_x_speed()
	else:
		character_animation.set_in_air_state()
	
	if x_input != 0:
		character_animation.grounded_movement(x_input)
		player_character.move_x(x_input * ACCELERATION, MAX_X_SPEED)	
	else:
		character_animation.grounded_movement(x_input)
		player_character.stop_x(FRICTION, AIR_RESISTANCE)
		
	if Input.is_action_just_pressed("ui_accept"):	
		character_animation.jump()
		player_character.jump_ascend(JUMP_FORCE)
		
	if Input.is_action_just_released("ui_accept"):
		character_animation.fall()
		player_character.fall(JUMP_FORCE)
		
	if _is_hanging and Input.is_action_pressed("ui_accept"):	
		character_animation.hang(x_input)
		player_character.hang(x_input)
		
	if Input.is_action_pressed("rocket") and rocket_pack and !rocket_pack.is_empty():
		character_animation.rocket()
		player_character.use_rocket_pack(rocket_pack.THRUST_POWER, MAX_Y_SPEED)	
		rocket_pack.consume_energy()
		hud.set_rocket_power_bar_value(rocket_pack.get_current_energy())
		
				
func set_is_hanging(is_hanging: bool) -> void:
	_is_hanging = is_hanging
	
func _equip_rocket_pack(rocket_pack_collected: RocketPack) -> void:
	rocket_pack = rocket_pack_collected
	rocket_pack.collected()
	hud.set_rocket_power_bar_max_value(rocket_pack.get_current_energy())
	hud.set_rocket_power_bar_value(rocket_pack.get_current_energy())
	hud.show_rocket_power_bar()
	
func _increase_rocket_power_if_player_max_x_speed():
	if rocket_pack and player_character.is_running_max_speed(MAX_X_SPEED):
		rocket_pack.increase_energy()
		hud.set_rocket_power_bar_value(rocket_pack.get_current_energy())		
		
