class_name TimerLabel
extends Control

signal time_over

export var max_countdown_seconds: float = 15.0

var countdown_active := true

onready var label := $Label as Label
onready var countdown_seconds := max_countdown_seconds


func _ready() -> void:
	pass # Replace with function body.
	
	
func _process(delta: float) -> void:
	if countdown_active:
		countdown_seconds -= delta
		timer_warning_check()
		label.text = str(stepify(countdown_seconds, 0.01))
		

func timer_warning_check() -> void:
	if countdown_seconds <= max_countdown_seconds / 2:
		label.add_color_override("font_color", Globals.RED)
		_timer_end_check()
		
func _timer_end_check() -> void:
	if countdown_seconds <= 0:
		countdown_seconds = 0
		emit_signal("time_over")
		queue_free()
