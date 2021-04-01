extends Node2D


func _ready():
	# Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	# Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	pass


func _physics_process(_delta):
	self.position = get_global_mouse_position()
