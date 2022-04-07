class_name CollectableCheckArea
extends Area2D

signal rocket_pack_collected


func _on_CollectableCheckArea_area_entered(area: Collectable) -> void:
	var collectable = area as RocketPack
	if collectable:
		emit_signal("rocket_pack_collected", collectable)
		return
