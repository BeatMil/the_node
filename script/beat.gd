extends Node2D

const ENEMY_PRE = preload("res://prefab/enemies/enemy.tscn")
const SMALL_TOWER_PRE = preload("res://prefab/tower/small_tower.tscn")
const BOMB_PRE = preload("res://prefab/special/bomb.tscn")
# var current_grid_pos = Vector2.ZERO  # unuse variable?
var can_spawn = true
onready var auto_beat = get_node("/root/AutoBeat")
onready  var spawn_timer = $spawn_timer

# order that enemy will spawn and the delay before spawn
# two dimension should be better
var enemy_count = 0
var enemy_army = [
		["normal",1],
		["normal",1],
		["normal",1],
		["boss",1],
		["boss",1],
		["boss",1],
]


func _ready():
	# connect timeout signal to spawn_enemy()
	if spawn_timer.connect("timeout",self,"spawn_enemy") != OK:
		print("error spawn_timer.connect() @beat.gd")
	# set wait time equal to the first delay and also the second one??...
	# this one is confusing.. I'm trying my best okay??
	spawn_timer.set_wait_time(enemy_army[enemy_count][1])
	spawn_timer.start()


func _process(_delta): # debuging with label
	$money_label.text = str(auto_beat.money)
	$console.text = str(auto_beat.is_blocked)
	$can_spawn.text = str(can_spawn)


#copy and paste boi. this code just checks if the mouse is colliding with anything
#useiing to check if it's colliding with a tile that has a collision. We's use this
#as a way to create a restricted area where players can't build.
func _physics_process(delta):
	# get the Physics2DDirectSpaceState object
	var space = get_world_2d().direct_space_state
	# Get the mouse's position
	var mousePos = get_global_mouse_position()
	# check spawn_mode
	if auto_beat.spawn_mode or auto_beat.bomb_mode:
		# Check if there is a collision at the mouse position
		if space.intersect_point(mousePos, 1):
			can_spawn = false
		else:
			can_spawn = true


func spawn_bomb():
	if auto_beat.buy_bomb(): # decrease money
		var bomb = BOMB_PRE.instance()
		bomb.set_position(get_viewport().get_mouse_position())
		self.add_child(bomb)


# This function is connected with spawn_timer
# enemy will spawn according to the enemy_army[]
# a boss enemy is an enemy but with higher hp and damage
func spawn_enemy():
	var enemy = ENEMY_PRE.instance()
	enemy.set_position($spawn_point.get_position())
	enemy.set_z_index(10)
	if enemy_count < enemy_army.size():
		match enemy_army[enemy_count][0]:
			"normal":
				# normal enemy
				enemy.name = "normal"
				enemy.way = "../way1/"
				enemy.damage = 1
				enemy.speed = 5
			"boss":
				# boss enemy
				enemy.name = "boss"
				enemy.way = "../way2/"
				enemy.type = "red"
				enemy.damage = 9
				enemy.speed = 16
				enemy.hp = 20
			_: # underscore meant default
				pass

	if enemy_count < enemy_army.size():
		# set the delay
		# timer needs to be set before using it
		# therefore to make it use it's own delay
		# it must be set before
		# this is hard to explain...(」°ロ°)」
		if enemy_count+1 == enemy_army.size():
			pass
		else:
			# set_wait_time just doesn't work if timer is not stopped
			spawn_timer.stop()
			spawn_timer.set_wait_time(enemy_army[enemy_count+1][1])
			spawn_timer.start()
		self.add_child(enemy)
	else:
		spawn_timer.stop()
	enemy_count += 1


func spawn_small_tower(position):
	# check if it overlaps other tower before spawning one
	# by searching for each node in tower group
	# and also the button group!
	var towers = get_tree().get_nodes_in_group("tower")
	for node in towers:
		if node.get_global_position() == position:
			can_spawn = false

	# beat: I'll keep this code here for now...
	# var buttons = get_tree().get_nodes_in_group("button")
	# for node in buttons:
	# 	if node.get_global_position() == position:
	# 		can_spawn = false



	if can_spawn:
		# auto_beat.buy_small_tower() is now return boolean
		# it checks money before return boolean
		if auto_beat.buy_small_tower():
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

	# check bomb_mode
	if event is InputEventMouseButton and auto_beat.bomb_mode:
		if event.button_index == BUTTON_LEFT and event.pressed and can_spawn:
			spawn_bomb()
