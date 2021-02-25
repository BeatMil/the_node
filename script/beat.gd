extends Node2D

const ENEMY_PRE = preload("res://prefab/enemies/enemy.tscn")
const SMALL_TOWER_PRE = preload("res://prefab/tower/small_tower.tscn")
var current_grid_pos = Vector2.ZERO
onready var auto_beat = get_node("/root/AutoBeat")


func _ready():
	var spawn_timer = $spawn_timer
	spawn_timer.set_wait_time(1)
	if spawn_timer.connect("timeout",self,"spawn_enemy") != OK:
		print("error $spawn_timer.connect() @beat.gd")
	spawn_timer.start()


func _process(_delta): # debuging with label
	$money_label.text = str(auto_beat.money)
	pass
	# $console.text = str(auto_beat.is_blocked)


func spawn_enemy():
	var enemy = ENEMY_PRE.instance()
	enemy.set_position($spawn_point.get_position())
	enemy.damage = 1
	enemy.speed = 5
	enemy.way = "../way1/"
	self.add_child(enemy)


func spawn_small_tower(position):
	# check if it overlaps other tower before spawning one
	# by searching for each node in tower group
	var can_spawn = true
	var is_enough_money = false
	var towers = get_tree().get_nodes_in_group("tower")
	for node in towers:
		if node.get_global_position() == position:
			can_spawn = false
	var buttons = get_tree().get_nodes_in_group("button")
	for node in buttons:
		if node.get_global_position() == position:
			can_spawn = false
	# checks money
	if auto_beat.money - auto_beat.small_tower_price < 0:
		print("not enough money")
	else:
		is_enough_money = true


	if can_spawn and is_enough_money:
		auto_beat.buy_small_tower()
		var tower = SMALL_TOWER_PRE.instance()
		tower.set_position(position)
		self.add_child(tower)


func _input(event):
	# spawn tower at left mouse click via grid
	if event is InputEventMouseButton and auto_beat.spawn_mode:
		if event.button_index == BUTTON_LEFT and event.pressed and not auto_beat.is_blocked:
			var mouse_pos = get_viewport().get_mouse_position()
			var grid_pos_x = (int(mouse_pos.x)/64)*64
			var grid_pos_y = (int(mouse_pos.y)/64)*64
			var grid_pos = Vector2(grid_pos_x,grid_pos_y)
			spawn_small_tower(grid_pos)

