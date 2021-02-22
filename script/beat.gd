extends Node2D

const ENEMY_PRE = preload("res://prefab/enemy.tscn")

func _ready():
	var spawn_timer = $spawn_timer 
	spawn_timer.set_wait_time(1)
	if spawn_timer.connect("timeout",self,"spawn_enemy") != OK:
		print("error $spawn_timer.connect() @beat.gd")
	spawn_timer.start()
	

func spawn_enemy():
	var enemy = ENEMY_PRE.instance()
	enemy.set_position($spawn_point.get_position())
	enemy.damage = 1
	enemy.speed = 5
	enemy.way = "../way1/"
	self.add_child(enemy)


