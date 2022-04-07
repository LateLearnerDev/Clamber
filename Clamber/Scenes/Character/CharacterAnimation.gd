class_name CharacterAnimation
extends AnimationPlayer

onready var animation_tree := $AnimationTree as AnimationTree


func _ready() -> void:
	animation_tree.active = true
	

func set_ground_state() -> void:
	animation_tree.set("parameters/state/current", 0)
	
	
func set_in_air_state() -> void:
	animation_tree.set("parameters/state/current", 1)
	animation_tree.set("parameters/in_air/current", 0)


func grounded_movement(moving_x: float) -> void:
	animation_tree.set("parameters/movement/current", moving_x != 0)
		
	
func jump() -> void:
	animation_tree.set("parameters/in_air/current", 1)


func fall() -> void:
	animation_tree.set("parameters/in_air/current", 0)
	
	
func hang(moving_x: float) -> void:
	animation_tree.set("parameters/in_air/current", 2)
	animation_tree.set("parameters/hanging/current", moving_x != 0)
	
func rocket() -> void:
	animation_tree.set("parameters/in_air/current", 3)
