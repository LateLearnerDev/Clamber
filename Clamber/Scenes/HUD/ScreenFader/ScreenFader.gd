class_name ScreenFader
extends CanvasLayer

onready var animation_player := $AnimationPlayer as AnimationPlayer
onready var sprite := $Sprite as Sprite

func _ready() -> void:
	sprite.visible = false

func fade_out() -> void:
	sprite.visible = true
	animation_player.play("fade_out")
