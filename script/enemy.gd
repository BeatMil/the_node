extends Node2D

export var group = 1
export var node_number = 1
export var speed = 0.2


# beat function helper
var is_moving = false # making it move linearly helper
var the_position = Vector2.ZERO
var node_position = Vector2.ZERO

func _ready():
	var first_node = get_node("../way1/1")
	tween_move(first_node)
	print("ok")
	pass # Replace with function body.


func _physics_process(_delta):
	if node_number <= 0:
		node_number = 1
	elif node_number == 1:
		# move to node #1
		pass


# beat function 
func move_to_node(node, delta):
	if not is_moving:
		var current_postion = $".".position
		node_position = node.position
		the_position = node_position - current_postion
		is_moving = true
	elif is_moving:
		print(the_position)
		# keep moving until the destination
		if $".".get_position() <= node_position:
			move_local_x(the_position.x * delta * speed)
			move_local_y(the_position.y * delta * speed)


# the tween fucnction
func tween_move(node):
	var current_position = $".".get_position()
	var desination = node.get_position()
	var tween = get_node("Tween")
	tween.interpolate_property($".", "position",
		current_position, desination, 2,
		Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween.start()


# sinal from the area2D "hibox"- runs function on entering other area2D. we can actually use 
# a parent node as a way to indicate witch group of waypoints the enemies should follow
func _on_hitbox_area_entered(area):
	if area.is_in_group("waypoint"):
		node_number += 1  
		var str_node = str(node_number)
		var new_destination = "../way1/" + str_node
		var new_node = get_node(new_destination)
		tween_move(new_node)

	
	
	
	
	
