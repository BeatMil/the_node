extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if get_node_or_null("beat"):
		print("found")
	else:
		print("not found")


