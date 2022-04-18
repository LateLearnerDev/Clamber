class_name TicketTimer
extends Node2D

onready var ticket := $Ticket as Ticket
onready var timer := $Timer as TimerLabel


func _ready() -> void:
	ticket.set_deferred("monitorable", false)
	timer.connect("time_over", self, "_remove")

func _remove() -> void:
	ticket.remove()
	timer.remove()
	
	
func is_time_remaining() -> bool:
	return timer.is_time_remaining() if timer else false
	
	
func stop_timer() -> void:
	timer.stop()
	
	
func collect_ticket() -> void:
	ticket.collected()
	
	
func get_ticket() -> Ticket:
	return ticket
