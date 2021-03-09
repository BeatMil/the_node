extends Node2D


const FIRST_STAGE = "res://scene/beat.tscn"


func _ready():
	pass


func _on_Button_button_down():
	print(get_tree().change_scene(FIRST_STAGE))
