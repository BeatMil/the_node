extends Node2D

export var node_number = 1
export var speed = 3
export var way = "../way1/"
export var damage = 2
export var hp = 3
export var type = "blue"
onready var health_bar = $"health_bar"

# beat function helper
var is_moving = false # making it move linearly helper
var the_position = Vector2.ZERO
var node_position = Vector2.ZERO

func _ready():
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

	# set max hp and hp to health_bar
	health_bar.max_value = hp
	health_bar.value = hp


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
	if hp <= 0:
		queue_free()
	health_bar.value = hp


