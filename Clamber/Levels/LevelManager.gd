class_name LevelManager
extends Node2D

const PAUSE_BEFORE_FADE_OUT := 3

var level_complete: bool

onready var player_manager := $PlayerManager as PlayerManager
onready var character_collectable_check_area := $PlayerManager/Character/CollectableCheckArea as CollectableCheckArea
onready var character_animation := $PlayerManager/Character/CharacterAnimation as CharacterAnimation
onready var level_exit_lift := $LeveExitLift as LevelExitLift
onready var screen_fader := $ScreenFader as ScreenFader
onready var ticket_timer := $TicketTimer as TicketTimer
onready var fade_out_timer := $FadeOutTimer as Timer


func _ready() -> void:
	level_complete = false
	if level_exit_lift:
		level_exit_lift.connect("level_exit_reached", self, "_level_complete")
	

func _level_complete() -> void:
	level_complete = true
	player_manager.lock_player()
	character_animation.play("Celebration1")
	if ticket_timer.is_time_remaining():
		ticket_timer.stop_timer()
		ticket_timer.collect_ticket()
		player_manager.collect_ticket(ticket_timer.get_ticket())
	
	_delayed_fade_out_animation() 
	
func _delayed_fade_out_animation() -> void:
	fade_out_timer.start(PAUSE_BEFORE_FADE_OUT)
	yield(fade_out_timer, "timeout")	
	screen_fader.fade_out()
	
	


