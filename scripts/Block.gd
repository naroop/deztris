extends KinematicBody2D

onready var points = [$Body/b1, $Body/b2, $Body/b3, $Body/b4]

var inputs = {
	"right": Vector2.RIGHT, 
	"left": Vector2.LEFT, 
	"down": Vector2.DOWN,
	"rotate": null,
	"slam": null
}

func _ready():
	Game.timer.connect("timeout", self, "_on_Timer_timeout")
	Game.startTimer()

func _physics_process(_delta):
	if Input.is_action_just_pressed("left"):
		action("left")
	if Input.is_action_just_pressed("right"):
		action("right")
	if Input.is_action_just_pressed("rotate"):
		action("rotate")
	if Input.is_action_pressed("down"):
		action("down")
	if Input.is_action_just_pressed("slam"):
		action("slam")

func action(action):
	if (action == "rotate"):
		if (name == "Z1" or name == "Z2" or name == "L"):
			halfRotate()
		elif (name == "S"):
			return
		else:
			attemptRotate(90, false)
	elif (action == "slam"):
		while(true):
			var prevPos = position
			if(move_and_collide(Vector2.DOWN * Game.TILE_SIZE)):
				position = prevPos
				break
	else:
		var prevPos = position
		if (move_and_collide(inputs[action] * Game.TILE_SIZE)):
			position = prevPos

func _on_Timer_timeout():
	if (move_and_collide(Vector2.DOWN * Game.TILE_SIZE)):
		Game.blockCoords = points
		Game.inPlace = true
		print(String(Game.inPlace))

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
