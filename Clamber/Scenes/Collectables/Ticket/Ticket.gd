class_name Ticket
extends Collectable

const SPEED := 100

onready var sprite := $Sprite as Sprite
onready var got_sprite := $GOT as Sprite
onready var collectable_animation := $CollectableAnimation as AnimationPlayer


func collected() -> void:
	sprite.visible = false
	set_deferred("monitorable", false)
	got_sprite.visible = true
	collectable_animation.play("GOT")
	yield(collectable_animation, "animation_finished")
	got_sprite.visible = false
	
	
func remove() -> void:
	sprite.visible = false
	set_deferred("monitorable", false)
