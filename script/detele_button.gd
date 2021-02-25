extends Node2D


onready var auto_beat = get_node("/root/AutoBeat")


func _ready():
	pass # Replace with function body.


func _on_Button_toggled(button_pressed):
	if button_pressed:
		auto_beat.set_delete_mode(true)
		auto_beat.turn_off_all_mode_except(self.name)
	else:
		auto_beat.set_delete_mode(false)
