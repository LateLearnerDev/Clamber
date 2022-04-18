class_name Hud
extends Control

onready var rocket_power_bar := $RocketBarContainer/RocketPowerBar as RocketPowerBar
onready var ticket_counter := $TicketCounterContainer/TicketCounter as TicketCounter

func _ready() -> void:
	pass


func show_rocket_power_bar() -> void:
	rocket_power_bar.show()
	
func set_rocket_power_bar_value(value: int) -> void:
	rocket_power_bar.set_current_value(value)
	
func set_rocket_power_bar_max_value(value: int) -> void:
	rocket_power_bar.set_max_value(value)
	

func set_current_ticket_count(value: int) -> void:
	ticket_counter.set_current_ticket_count(value)
	
	
	

	


