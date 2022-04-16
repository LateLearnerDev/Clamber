class_name Background
extends ParallaxBackground

export var texture: Texture

onready var sprite := $ParallaxLayer/Sprite as Sprite

func _ready() -> void:
	sprite.texture = texture
