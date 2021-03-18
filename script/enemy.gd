extends Node2D

export var node_number = 1
export var speed = 3
export var way = "../way1/"
export var damage = 2
export var hp = 3
export var type = "none"
onready var health_bar = $"health_bar"
onready var auto_beat = get_node("/root/AutoBeat")
onready var heavy_beep = load("res://media/sfx/arcade_beep_heavy.ogg")
onready var beep = load("res://media/sfx/arcade_beep.ogg")

# signal emitted when this enemy queue freed
signal signal_clear
var stage_clear = false

# beat function helper
var is_moving = false # making it move linearly helper
var the_position = Vector2.ZERO
var node_position = Vector2.ZERO

func _ready():
	# play spawn noise
	match self.name:
		"normal":
			$AudioStreamPlayer.set_stream(beep)
			$AudioStreamPlayer.play()
		"boss":
			$AudioStreamPlayer.set_stream(heavy_beep)
			$AudioStreamPlayer.play()

	var first_node = get_node(way + "1")
	tween_move(first_node)
	#godot switch case very cool
	match type:
		"red":
			get_node("icon").modulate = Color(1,0,0)
		"green":
			get_node("icon").modulate = Color(0,1,0)
		"blue":
			get_node("icon").modulate = Color(0,0,1)
		"none":
			get_node("icon").modulate = Color(1,1,1)

	# set max hp and hp to health_bar
	health_bar.max_value = hp
	health_bar.value = hp

	# when this node get queue_freed it will emit signal
	# said that player cleared the stage!
	if stage_clear:
		print(connect("signal_clear",get_parent(),"beat_clear"),"connect_stage_clear")

func _physics_process(_delta):
	if node_number <= 0:
		node_number = 1
	elif node_number == 1:
		# move to node #1
		pass


# the tween fucnction
func tween_move(node):
	var current_position = $".".get_position()
	var desination = node.get_position()
	var tween = get_node("Tween")
	tween.interpolate_property($".", "position",
		current_position, desination, speed,
		Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween.start()


# signal from the area2D "hibox"- runs function on entering other area2D. we can actually use
# a parent node as a way to indicate which group of waypoints the enemies should follow
func _on_hitbox_area_entered(area):
	if area.is_in_group("waypoint"):
		node_number += 1
		var str_node = str(node_number)
		var new_destination = way + str_node
		if get_node_or_null(new_destination):
			var new_node = get_node(new_destination)
			tween_move(new_node)


# always create getter and setter. They are great!
# these way health_bar can display the health when something changes
func decrease_hp(amount : int):
	hp -= amount
	# if there is normal in the name or boss in the name
	# then get money for it
	# this is used with beat.gd spawn_enemy()
	if hp <= 0:
		if $".".name.find("normal") > -1:
			auto_beat.add_money(200)
			print("normal money")
		elif $".".name.find("boss") > -1:
			auto_beat.add_money(1000)
			print("boss money")
		if stage_clear:
			queue_free()
			emit_signal("signal_clear")
		queue_free()
	health_bar.value = hp
