extends Node2D

var current_grid = Vector2.ZERO
var green = Color(0.3, 0.8, 0.0)
var red = Color(0.8, 0.1, 0.0)

func _ready():
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
	print("beat_green")
	$icon.set_modulate(green)


func set_color_red():
	print("beat_red")
	$icon.set_modulate(red)
