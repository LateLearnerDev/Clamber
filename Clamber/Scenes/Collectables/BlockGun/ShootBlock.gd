class_name ShootBlock
extends KinematicBody2D

signal fired
signal removed

var velocity: Vector2
var speed: int

const UP_TIME := 3.0

func _ready() -> void:
	emit_signal("fired")
	
func setup(new_transform: Transform, new_velocity: Vector2, new_speed: int) -> void:
	self.transform = new_transform
	self.velocity = new_velocity
	self.speed = new_speed
	
func _physics_process(delta: float) -> void:
	var collision_info: KinematicCollision2D = move_and_collide(velocity.normalized() * delta * speed)
	if collision_info:
		var collision_oject := collision_info.collider as Node2D
		
		if collision_oject.get_collision_layer_bit(0):
			velocity = Vector2.ZERO
			set_physics_process(false)
			_countdown_queue_free()


func _countdown_queue_free() -> void:
	var timer := Timer.new()
	get_parent().add_child(timer)
	timer.start(UP_TIME)
	yield(timer, "timeout")
	emit_signal("removed")
	queue_free()
