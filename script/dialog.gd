extends Node2D

export var dialog = ""
var counter = 0 # indicate how many letter are showing
onready var letter_amount = len(dialog)

func _ready():
	$Timer.start()


func _on_Timer_timeout():
	if counter < letter_amount:
		counter += 1
		$Label.text = dialog.substr(0,counter)
	else:
		$Timer.stop()
		$queue_free_timer.start()


func _on_queue_free_timer_timeout():
	queue_free()
