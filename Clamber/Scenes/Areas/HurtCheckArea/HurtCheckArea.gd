class_name HurtCheckArea
extends Area2D

signal death_area_entered


func _on_HurtCheckArea_area_entered(area: Area2D) -> void:
	var hurt_area = area as DeathArea
	if hurt_area: 
		emit_signal("death_area_entered")
		return
