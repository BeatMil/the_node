extends Node2D

var current_grid = Vector2.ZERO
var green = Color(0.3, 0.8, 0.0)
var red = Color(0.8, 0.1, 0.0)
onready var auto_beat = get_node("/root/AutoBeat")

func _ready():
	if auto_beat.spawn_mode:
		$range.set_visible(true)
	else:
		$range.set_visible(false)
	set_color_green()

func _input(event):
	if event is InputEventMouseMotion:
		if current_grid != get_grid_pos():
			current_grid = get_grid_pos()
		$Label.text = str(current_grid)
		set_position(current_grid)


# get the position fix on grid
func get_grid_pos():
	var mouse_pos = get_viewport().get_mouse_position()
	var grid_pos_x = (int(mouse_pos.x)/64)*64
	var grid_pos_y = (int(mouse_pos.y)/64)*64
	return Vector2(grid_pos_x,grid_pos_y)


func set_color_green():
	$icon.set_modulate(green)


func set_color_red():
	$icon.set_modulate(red)


func _on_Area2D_area_entered(area):
	# turns red if playaer cannot place a tower
	if area.is_in_group("tower") or area.is_in_group("restricted_area"):
		set_color_red()


func _on_Area2D_area_exited(area):
	# turns green if playaer can place a tower
	if area.is_in_group("tower") or area.is_in_group("restricted_area"):
		set_color_green()


func _on_Area2D_body_entered(body):
	if body.is_in_group("tower") or body.is_in_group("restricted_area"):
		set_color_red()


func _on_Area2D_body_exited(body):
	if body.is_in_group("tower") or body.is_in_group("restricted_area"):
		set_color_green()
