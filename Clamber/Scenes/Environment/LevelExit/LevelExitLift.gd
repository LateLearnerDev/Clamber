class_name LevelExitLift
extends Node2D

signal level_exit_reached

const SPEED: float = 5.0
const IDLE_DURATION: float = 1.0
const FULL_DURATION: float = 4.0

export var move_to := Vector2.UP * 192

onready var moving_platform := $MovingPlatform as KinematicBody2D
onready var tween := $Tween as Tween
onready var player_detection := $MovingPlatform/PlayerDetection as Area2D
var _direction := Vector2.UP

func _ready() -> void:
	pass # Replace with function body.



func _on_PlayerDetection_body_entered(body: Node) -> void:
	var character := body as Character
	if character:
		_init_tween()
		emit_signal("level_exit_reached")
		
func _init_tween() -> void:
	var duration = move_to.length() / float(SPEED * Globals.TILE_SIZE)
	tween.interpolate_property(moving_platform, "position", Vector2.ZERO, move_to, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, IDLE_DURATION)
	tween.start()
	player_detection.queue_free()
