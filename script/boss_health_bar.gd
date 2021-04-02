extends Node2D

func _ready():
	print(self.filename)
	$ani_player.play("intro")
