extends Node2D

const PAUSE_BEFORE_FADE_OUT := 3

onready var player_manager := $PlayerManager as PlayerManager
onready var character_animation := $PlayerManager/Character/CharacterAnimation as CharacterAnimation
onready var level_exit_lift := $LeveExitLift as LevelExitLift
onready var screen_fader := $ScreenFader as ScreenFader


func _ready() -> void:
	level_exit_lift.connect("level_exit_reached", self, "_level_complete")

func _level_complete() -> void:
	player_manager.lock_player()
	character_animation.play("Celebration1")
	_delayed_fade_out_animation()
	
func _delayed_fade_out_animation() -> void:
	var timer := Timer.new()
	get_parent().add_child(timer)
	timer.start(PAUSE_BEFORE_FADE_OUT)
	yield(timer, "timeout")
	screen_fader.fade_out()
	
