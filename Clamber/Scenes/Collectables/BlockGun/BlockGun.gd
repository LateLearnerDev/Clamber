class_name BlockGun
extends Collectable

const POWER: int = 150
const MAX_BLOCKS_FIRED: int = 2

export var Block: PackedScene

var _blocks_fired_count: int = 0
onready var sprite := $Sprite as Sprite

func _ready() -> void:
	pass 
	
	
func shoot(start_pos: Transform, direction: Vector2) -> void:
	if _blocks_fired_count < MAX_BLOCKS_FIRED:
		var block := Block.instance() as ShootBlock
		block.connect("fired", self, "increment_blocks_fired_count")
		block.connect("removed", self, "decrement_blocks_fired_count")
		block.setup(start_pos, direction, POWER)
		get_parent().add_child(block)
	

func collected() -> void:
	sprite.visible = false
	set_deferred("monitorable", false)
	
	
func increment_blocks_fired_count() -> void:
	_blocks_fired_count += 1
	
func decrement_blocks_fired_count() -> void:
	_blocks_fired_count -= 1

