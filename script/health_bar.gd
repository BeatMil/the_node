extends ProgressBar


const GREEN_BOX = preload("res://media/stylebox/green_stylebox.tres")
const RED_BOX = preload("res://media/stylebox/red_stylebox.tres")
const ORANGE_BOX = preload("res://media/stylebox/orange_stylebox.tres")



func _ready():
	health_color_adjuster()
	
func _on_health_bar_value_changed(_value):
	health_color_adjuster()


func health_color_adjuster():
	var percent = value/max_value
	if percent >= 0.7:
		set("custom_styles/fg",GREEN_BOX)
	elif percent >= 0.4:
		set("custom_styles/fg",ORANGE_BOX)
	else:
		set("custom_styles/fg",RED_BOX)
