class_name CharacterAnimation
extends AnimationPlayer

enum State {GROUND, AIR}
enum GroundMovement {IDLE, RUN, IDLE_ROCKET, RUN_ROCKET}
enum InAir {JUMPING, HANGING, ROCKET, JUMPING_ROCKET}
enum Hanging {HANG_IDLE, HANG_MOVE, HANG_IDLE_ROCKET, HANG_MOVE_ROCKET}

var _grounded_movement_func: FuncRef = funcref(self, "_grounded_movement")
var _jump_func: FuncRef = funcref(self, "_jump")
var _hang_func: FuncRef = funcref(self, "_hang")

onready var animation_tree := $AnimationTree as AnimationTree


func _ready() -> void:
	animation_tree.active = true
	

func set_ground_state() -> void:
	animation_tree.set("parameters/state/current", State.GROUND)

func set_in_air_state() -> void:
	animation_tree.set("parameters/state/current", State.AIR)


func grounded_movement(moving_x: float) -> void:
	_grounded_movement_func.call_func(moving_x)

func _grounded_movement(moving_x: float) -> void:
	animation_tree.set("parameters/movement/current", moving_x != GroundMovement.IDLE)

func _grounded_movement_rocket_pack(moving_x: float) -> void:
	animation_tree.set("parameters/movement/current", GroundMovement.RUN_ROCKET if moving_x != GroundMovement.IDLE else GroundMovement.IDLE_ROCKET)
	

func jump() -> void:
	_jump_func.call_func()
	
func _jump() -> void:
	animation_tree.set("parameters/in_air/current", InAir.JUMPING)
	
func _jump_rocket_pack() -> void:
	animation_tree.set("parameters/in_air/current", InAir.JUMPING_ROCKET)
	
	
func hang(moving_x: float) -> void:
	_hang_func.call_func(moving_x)
	
func _hang(moving_x: float) -> void:
	animation_tree.set("parameters/in_air/current", InAir.HANGING)
	animation_tree.set("parameters/hanging/current", moving_x != Hanging.HANG_IDLE)
	
func _hang_rocket_pack(moving_x: float) -> void:
	animation_tree.set("parameters/in_air/current", InAir.HANGING)
	animation_tree.set("parameters/hanging/current", Hanging.HANG_MOVE_ROCKET if moving_x != Hanging.HANG_IDLE else Hanging.HANG_IDLE_ROCKET)
	
	
func rocket() -> void:
	animation_tree.set("parameters/in_air/current", InAir.ROCKET)

func set_rocket_pack_eqipped() -> void:
	_grounded_movement_func = funcref(self, "_grounded_movement_rocket_pack")
	_jump_func = funcref(self, "_jump_rocket_pack")
	_hang_func = funcref(self, "_hang_rocket_pack")
	

func disable_tree() -> void:
	animation_tree.active = false

