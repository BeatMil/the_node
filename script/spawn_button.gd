extends Node2D

onready var auto_beat = get_node("/root/AutoBeat")
const MOUSE_PRE = preload("res://prefab/mouse_grid.tscn")


func spawn_mouse():
	var mouse = MOUSE_PRE.instance()
	get_parent().add_child(mouse)


func delete_mouse():
	get_parent().get_node_or_null("mouse_grid").queue_free()


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
		auto_beat.set_spawn_mode(false)
		delete_mouse()
