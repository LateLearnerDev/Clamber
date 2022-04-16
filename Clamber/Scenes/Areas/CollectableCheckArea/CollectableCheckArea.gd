class_name CollectableCheckArea
extends Area2D

signal rocket_pack_collected
signal block_gun_collected
signal ticket_collected


func _on_CollectableCheckArea_area_entered(area: Collectable) -> void:
	var collectable = area as RocketPack
	if collectable:
		emit_signal("rocket_pack_collected", collectable)
		return
		
	collectable = area as BlockGun
	if collectable:
		emit_signal("block_gun_collected", collectable)
		return
		
	collectable = area as Ticket
	if collectable:
		emit_signal("ticket_collected", collectable)
		return
