extends Node2D

onready var tileMap = get_parent().get_node("Blocks")
onready var gameOverScreen = get_parent().get_node("GameOver")
var currentBlock: KinematicBody2D
var currentColor: String

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	spawnNewBlock()

func spawnNewBlock():
	Game.inPlace = false
	Game.createTimer()
	
	var blockName = Game.BLOCKS.keys()[ randi() % Game.BLOCKS.size() ]
	print("spawned " + blockName)
	currentBlock = load(Game.BLOCKS[blockName]).instance()
	currentColor = Game.BLOCK_COLORS[blockName]
	
	add_child(currentBlock)
	Game.startTimer()

func _process(_delta):
	if (Game.inPlace == true):
		Game.inPlace = false
		Game.destroyTimer()
		tileMap.placeBlocksOnTileMap(Game.blockCoords, currentColor)
		if (!Game.gameOver):
			tileMap.lineHandler()
			remove_child(currentBlock)
			spawnNewBlock()
		else:
			gameOver()
			
func gameOver():
	gameOverScreen.visible = true
	while(true):
		if Input.is_action_just_pressed("restart"):
			restartGame()
			break
		if Input.is_action_just_pressed("exit"):
			get_tree().quit()

func restartGame():
	Game.resetVariables()
	tileMap.resetMapsAndUI()
	gameOverScreen.visible = false
	spawnNewBlock()

