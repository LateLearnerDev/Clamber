class_name Portals
extends Node2D

onready var portal_A_spawn_pos := $PortalA/PortalASpawnPos as Position2D
onready var portal_B_spawn_pos := $PortalB/PortalBSpawnPos as Position2D

func _ready() -> void:
	pass


func _on_PortalA_body_entered(body: Node) -> void:
	var spawn_height = body.position.y - portal_A_spawn_pos.global_position.y
	body.position = Vector2(portal_B_spawn_pos.global_position.x, portal_B_spawn_pos.global_position.y + spawn_height)


func _on_PortalB_body_entered(body: Node) -> void:
	var spawn_height = body.position.y - portal_B_spawn_pos.global_position.y
	body.position = Vector2(portal_A_spawn_pos.global_position.x, portal_A_spawn_pos.global_position.y + spawn_height)
