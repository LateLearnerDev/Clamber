class_name BounceBackTile
extends StaticBody2D

export var bounce_right := true

onready var bounce_back_area := $BouncBackArea as Area2D
onready var animation_player := $AnimationPlayer as AnimationPlayer


func _on_BouncBackArea_body_entered(body: Node) -> void:
	var shoot_block := body as ShootBlock
	if shoot_block:
		var direction := Vector2.LEFT if bounce_right else Vector2.RIGHT
		animation_player.play("Activated")
		shoot_block.set_direction(direction)
		
