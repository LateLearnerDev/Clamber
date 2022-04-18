class_name ShootCheckArea
extends Area2D

	
func can_shoot() -> bool:
	return false if get_overlapping_bodies().size() > 0 else true
