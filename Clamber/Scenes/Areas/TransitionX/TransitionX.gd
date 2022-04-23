class_name TransitionX
extends Area2D

signal transition_x_triggered

export var _is_transition_right := true

var transition_triggered := false



func _on_TransitionX_body_entered(body: Node) -> void:
	if transition_triggered:
		return
	
	var player_character := body as Character
	if player_character:
		emit_signal("transition_x_triggered", _is_transition_right)
		transition_triggered = true



func _on_TransitionExit_body_entered(body: Node) -> void:
	if transition_triggered:
		var player_character := body as Character
		if player_character:
			emit_signal("transition_x_triggered", !_is_transition_right)
			transition_triggered = false
