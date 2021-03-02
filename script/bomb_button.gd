extends Node2D


func _ready():
	pass # Replace with function body.


func _on_Button_toggled(button_pressed):
	if button_pressed:
		print("bomb mode on")
	else:
		print("bomb mode off")
