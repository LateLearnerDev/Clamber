class_name HangCheckArea
extends Area2D

signal hang_collider_entered
signal hang_collider_exited

func _on_HangCheckArea_area_entered(area: Area2D) -> void:
	var hang_collider := area as HangCollider
	if hang_collider:
		emit_signal("hang_collider_entered")


func _on_HangCheckArea_area_exited(area: Area2D) -> void:
	var hang_collider := area as HangCollider
	if hang_collider:
		emit_signal("hang_collider_exited")
