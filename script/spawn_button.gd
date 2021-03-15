extends Node2D

onready var auto_beat = get_node("/root/AutoBeat")
const MOUSE_PRE = preload("res://prefab/mouse_grid.tscn")


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
	# turn off all modes
	# then set spawn mode on
	if button_pressed:
		auto_beat.toggle_off_button_except("spawn_tower")
		auto_beat.turn_off_all_mode()
		auto_beat.set_spawn_mode(true)
		auto_beat.set_is_blocked(false)
		spawn_mouse() # the cursor; red if cant spawn in the tile
		# green if can spawn in the tile
	else:
		delete_mouse()
		auto_beat.set_spawn_mode(false)
