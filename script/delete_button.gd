extends Node2D


onready var auto_beat = get_node("/root/AutoBeat")


func _ready():
	pass # Replace with function body.


func _on_Button_toggled(button_pressed):
	# turn off all modes
	# then set delete mode on
	if button_pressed:
		auto_beat.toggle_off_button_except("delete_tower")
		auto_beat.turn_off_all_mode()
		auto_beat.set_delete_mode(true)
	else:
		auto_beat.set_delete_mode(false)
