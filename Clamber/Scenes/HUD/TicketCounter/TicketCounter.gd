class_name TicketCounter
extends HBoxContainer

onready var label := $Label as Label

func set_current_ticket_count(value: int) -> void:
	label.text = str("x", value)
