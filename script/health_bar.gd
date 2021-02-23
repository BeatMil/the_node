extends ProgressBar

# set of colors
const BLUE = Color(0.03, 0.25, 0.76)
const GREEN = Color(0.25, 0.80, 0.20)
const ORANGE = Color(0.81, 0.32, 0.09)
const RED = Color(0.87, 0.11, 0.11)

const GREEN_BOX = preload("res://media/stylebox/green_stylebox.tres")

# call once and done
#var style_box = $".".get("custom_styles/fg")


func _ready():
	var green_box = StyleBoxFlat
#	green_box.bg_color = GREEN
	print(green_box.bg_color)
	health_color_adjuster()


func _on_health_bar_value_changed(_value):
	health_color_adjuster()


func health_color_adjuster():
	var percent = value/max_value
	if percent >= 0.6:
		self.get("custom_styles/fg") = GREEN_BOX
	elif percent >= 0.4:
		self.get("custom_styles/fg").bg_color = ORANGE
	else:
		self.get("custom_styles/fg").bg_color = RED
