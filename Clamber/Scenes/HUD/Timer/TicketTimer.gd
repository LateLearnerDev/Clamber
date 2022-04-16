class_name TicketTimer
extends Node2D

onready var ticket := $Ticket as Ticket
onready var timer := $Timer as Control


func _ready() -> void:
	timer.connect("time_over", self, "_remove_ticket")
	

func _remove_ticket() -> void:
	ticket.queue_free()
