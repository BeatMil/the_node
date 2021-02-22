extends ProgressBar


func _ready():
	var style_box = $".".get("custom_styles/fg")
	style_box.bg_color = Color(0.03, 0.25, 0.76)


func _on_health_bar_value_changed(value):
	pass # Replace with function body.


func health_color_adjuster():
	if value/max_value >= 0.6:
		pass
	pass
