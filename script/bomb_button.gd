extends Node2D


onready var auto_beat = get_node("/root/AutoBeat")


func _on_Button_toggled(button_pressed):
	# turn toggle off expect this one
	# turn off all mode
	# turn this mode on
	if button_pressed:
		auto_beat.toggle_off_button_except("bomb_button")
		auto_beat.turn_off_all_mode()
		auto_beat.set_bomb_mode(true)
		print("bomb mode on")
	else:
		auto_beat.set_bomb_mode(false)
		print("bomb mode off")
