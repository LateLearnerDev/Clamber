class_name HangCheckArea
extends Area2D

signal hang_collider_entered
signal hang_collider_exited

func _on_HangCheckArea_body_entered(body: Node2D) -> void:
	print('in')
	var hang_collider := body as HangCollider
	if hang_collider:
		emit_signal("hang_collider_entered")


func _on_HangCheckArea_body_exited(body: Node2D) -> void:
	print('out')
	var hang_collider := body as HangCollider
	if hang_collider:
		emit_signal("hang_collider_exited")
