class_name PlayerManager
extends Node2D

const MAX_X_SPEED: int = 100
const MAX_Y_SPEED: int = -100
const ACCELERATION: int = 5
const FRICTION: float = 0.8
const JUMP_FORCE: float = -275.0
const AIR_RESISTANCE: float = 0.02
const GRAVITY: float = 10.0

var rocket_pack: RocketPack = null
var block_gun: BlockGun = null
var current_ticket: Ticket = null
var tickets: Array
var _is_hanging := false setget set_is_hanging
var _shoot_spawn_x: float
var _is_unput_locked := false

onready var player_character := $Character as Character
onready var camera := $Camera as PlayerCam
onready var hang_check_area := $Character/HangCheckArea as HangCheckArea
onready var collectable_check_area := $Character/CollectableCheckArea as CollectableCheckArea
onready var shoot_check_area := $Character/ShootCheckArea as ShootCheckArea
onready var hurt_check_area := $Character/HurtCheckArea as HurtCheckArea
onready var character_animation := $Character/CharacterAnimation as CharacterAnimation
onready var shoot_pos_2d := $Character/ShootSpawnPosition as Position2D
onready var hud := $CanvasLayer/HUD as Hud


func _ready() -> void:
	hang_check_area.connect("hang_collider_entered", self, "set_is_hanging", [true])
	hang_check_area.connect("hang_collider_exited", self, "set_is_hanging", [false])
	collectable_check_area.connect("rocket_pack_collected", self, "_equip_rocket_pack")
	collectable_check_area.connect("block_gun_collected", self, "_equip_block_gun")
	collectable_check_area.connect("ticket_collected", self, "collect_ticket")
	hurt_check_area.connect("death_area_entered", self, "_kill_player")
	_shoot_spawn_x = _calculate_shoot_spawn_position_x()


func _physics_process(_delta: float) -> void:
	camera.move(player_character.position)
	if _is_unput_locked:
		return
	
	var x_input := Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	if x_input > 0:
		player_character.set_is_facing_right(true)
	elif x_input < 0:
		player_character.set_is_facing_right(false)
	
	if player_character.is_on_floor():
		character_animation.set_ground_state()
		_increase_rocket_power_if_player_max_x_speed()
	else:
		character_animation.set_in_air_state()
	
	if player_character.get_is_jumping():
		character_animation.jump()
	
	if x_input != 0:
		character_animation.grounded_movement(x_input)
		player_character.move_x(x_input * ACCELERATION, MAX_X_SPEED)
	else:
		character_animation.grounded_movement(x_input)
		player_character.stop_x(FRICTION, AIR_RESISTANCE)
		
	if Input.is_action_just_pressed("ui_accept"):
		player_character.jump_ascend(JUMP_FORCE)
		
	if Input.is_action_just_released("ui_accept"):
		player_character.fall(JUMP_FORCE)
		
	if _is_hanging and Input.is_action_pressed("ui_accept"):
		character_animation.hang(x_input)
		player_character.hang(x_input)
		
	if Input.is_action_pressed("rocket") and rocket_pack and !rocket_pack.is_empty():
		character_animation.rocket()
		player_character.use_rocket_pack(rocket_pack.THRUST_POWER, MAX_Y_SPEED)
		rocket_pack.consume_energy()
		hud.set_rocket_power_bar_value(rocket_pack.get_current_energy())
				
	if Input.is_action_just_pressed("shoot") and block_gun:
		shoot_pos_2d.position.x = _calculate_shoot_spawn_position_x()
		shoot_check_area.position.x = shoot_pos_2d.position.x
		if shoot_check_area.can_shoot():
			var direction = Vector2.RIGHT if player_character.get_is_facing_right() else Vector2.LEFT
			block_gun.shoot(shoot_pos_2d.global_transform, direction)
		

func lock_player() -> void:
	player_character.stop_moving()
	character_animation.disable_tree()
	_is_unput_locked = true

func set_is_hanging(is_hanging: bool) -> void:
	_is_hanging = is_hanging
	
	
func _calculate_shoot_spawn_position_x() -> float:
	return abs(shoot_pos_2d.position.x) if player_character.get_is_facing_right() else -abs(shoot_pos_2d.position.x)

	
func _equip_rocket_pack(rocket_pack_collected: RocketPack) -> void:
	rocket_pack = rocket_pack_collected
	rocket_pack.collected()
	hud.set_rocket_power_bar_max_value(rocket_pack.get_current_energy())
	hud.set_rocket_power_bar_value(rocket_pack.get_current_energy())
	hud.show_rocket_power_bar()
	character_animation.set_rocket_pack_eqipped()
	

func collect_ticket(ticket_collected: Ticket) -> void:
	current_ticket = ticket_collected
	current_ticket.collected()
	tickets.append(current_ticket)	
	hud.set_current_ticket_count(tickets.size())
	
	
func _equip_block_gun(block_gun_collected: BlockGun) -> void:
	block_gun = block_gun_collected
	block_gun.collected()
	
func _increase_rocket_power_if_player_max_x_speed():
	if rocket_pack and player_character.is_running_max_speed(MAX_X_SPEED):
		rocket_pack.increase_energy()
		hud.set_rocket_power_bar_value(rocket_pack.get_current_energy())		
		

func _kill_player() -> void:
	#player_character.die()
	var error := get_tree().reload_current_scene()
	if error:
		print(error)
	

func _on_Portals_special_portal_triggered() -> void:
	camera.set_current_x(Globals.GAME_RESOLUTION_X if player_character.get_is_facing_right() else -Globals.GAME_RESOLUTION_X)
	
	
