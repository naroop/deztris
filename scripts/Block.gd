extends KinematicBody2D

onready var points = [$Body/b1, $Body/b2, $Body/b3, $Body/b4]

var inputs = {
	"right": Vector2.RIGHT, 
	"left": Vector2.LEFT, 
	"down": Vector2.DOWN,"rotate": null
}

func _ready():
	GlobalVariables.timer.connect("timeout", self, "_on_Timer_timeout")
	GlobalVariables.startTimer()
	
func _unhandled_input(event):
	for action in inputs.keys():
		if event.is_action_pressed(action):
			action(action)

func action(action):
	if (action == "rotate"):
		if (name == "Z1" or name == "Z2" or name == "L"):
			halfRotate()
		elif (name == "S"):
			return
		else:
			attemptRotate(90, false)
	else:
		var prevPos = position
		if (move_and_collide(inputs[action] * GlobalVariables.tileSize)):
			position = prevPos

func _on_Timer_timeout():
	if (move_and_collide(Vector2.DOWN * GlobalVariables.tileSize)):
		GlobalVariables.blockCoords = points
		GlobalVariables.inPlace = true

func halfRotate():
	if (rotation_degrees == 90):
		attemptRotate(0, true)
	else:
		attemptRotate(90, true)

func attemptRotate(degrees, setting):
	var prevRotation = rotation_degrees
	var prevPosition = position
	if (setting): # attempt to rotate here
		rotation_degrees = degrees
	else:
		rotation_degrees += degrees 
	if (move_and_collide(Vector2.ZERO)):
		rotation_degrees = prevRotation
		position = prevPosition
