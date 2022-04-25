class_name Portals
extends Node2D

signal special_portal_triggered

export var special_enter_count_required: int = 3
export var is_special_A := false
export var is_special_B := false

var _portal_A_entered_count := 0
var _portal_B_entered_count := 0
var _is_special_A_accessed := false
var _is_special_B_accessed := false

onready var portal_A_spawn_pos := $PortalA/PortalASpawnPos as Position2D
onready var portal_B_spawn_pos := $PortalB/PortalBSpawnPos as Position2D
onready var portal_A_particles := $PortalA/PortalParticleEffect as Particles2D
onready var portal_B_particles := $PortalB/PortalParticleEffect as Particles2D

func _ready() -> void:
	pass

func _on_PortalA_body_entered(body: Node) -> void:
	if _is_special_A_accessed:		
		return
		
	if is_special_A and body is Character:
		if _portal_A_entered_count == special_enter_count_required:
			_trigger_special_portal()
			_is_special_A_accessed = true	
			return
			
		if _portal_A_entered_count == special_enter_count_required:
			portal_A_particles.process_material.set("color", Globals.GREEN)
		_portal_A_entered_count += 1
		
			
	var spawn_height = body.position.y - portal_A_spawn_pos.global_position.y
	body.position = Vector2(portal_B_spawn_pos.global_position.x, portal_B_spawn_pos.global_position.y + spawn_height)

func _on_SpecialExitA_body_entered(body: Node) -> void:
	if body is Character and _is_special_A_accessed:
		_trigger_special_portal()
		_is_special_A_accessed = false
		portal_A_particles.process_material.set("color", Globals.DARK_YELLOW)
		_portal_A_entered_count = 0


func _on_PortalB_body_entered(body: Node) -> void:
	if _is_special_B_accessed:
		return
	
	if is_special_B and body is Character:		
		if _portal_B_entered_count == special_enter_count_required:
			_trigger_special_portal()
			_is_special_B_accessed = true
			return
			
		_portal_B_entered_count += 1
		if _portal_B_entered_count == special_enter_count_required:
			portal_B_particles.process_material.set("color", Globals.GREEN)
	
	var spawn_height = body.position.y - portal_B_spawn_pos.global_position.y
	body.position = Vector2(portal_A_spawn_pos.global_position.x, portal_A_spawn_pos.global_position.y + spawn_height)
	
func _on_SpecialExitB_body_entered(body: Node) -> void:
	if body is Character and _is_special_B_accessed:
		_trigger_special_portal()
		_is_special_B_accessed = false
		portal_B_particles.process_material.set("color", Globals.DARK_YELLOW)
		_portal_B_entered_count = 0


func _trigger_special_portal():
	emit_signal("special_portal_triggered")


