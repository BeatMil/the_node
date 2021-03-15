extends Node2D


const MOUSE_PRE = preload("res://prefab/mouse_grid.tscn")
onready var auto_beat = get_node("/root/AutoBeat")


func spawn_mouse():
	var mouse = MOUSE_PRE.instance()
	# spawn mouse cursor on to the grid that real mouse is in.
	var mouse_pos = get_viewport().get_mouse_position()
	var grid_pos_x = (int(mouse_pos.x)/64)*64
	var grid_pos_y = (int(mouse_pos.y)/64)*64
	var grid_pos = Vector2(grid_pos_x,grid_pos_y)
	mouse.set_position(grid_pos)
	get_parent().add_child(mouse)


func delete_mouse():
	var buttons = get_parent().get_children()
	# check every node in buttons
	# find mouse
	# mouse spawn together and name changes...
	for button in buttons:
		if button.name.find("mouse_grid") > -1:
			button.queue_free()


func _on_Button_toggled(button_pressed):
	# turn toggle off expect this one
	# turn off all mode
	# turn this mode on
	if button_pressed:
		auto_beat.toggle_off_button_except("bomb_button")
		auto_beat.turn_off_all_mode()
		auto_beat.set_bomb_mode(true)
		spawn_mouse()
	else:
		delete_mouse()
		auto_beat.set_bomb_mode(false)
