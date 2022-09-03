extends Node2D

onready var tileMap = get_parent().get_node("Blocks")
onready var gameOverScreen = get_parent().get_node("GameOver")
onready var startGameScreen = get_parent().get_node("StartGame")
onready var pauseGameScreen = get_parent().get_node("PauseGame")
var currentBlock: KinematicBody2D
var currentColor: String

var waiting = true

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()

func spawnNewBlock():
	Game.inPlace = false
	Game.createTimer()
	
	var blockName = Game.BLOCKS.keys()[ randi() % Game.BLOCKS.size() ]
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
	if (waiting):
		if Input.is_action_just_pressed("start"):
			startGame()
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("pause"):
		pauseGame()
			
func gameOver():
	gameOverScreen.visible = true
	Game.gamePaused = true
	waiting = true
		
func startGame():
	startGameScreen.visible = false
	waiting = false
	Game.resetVariables()
	tileMap.resetMapsAndUI()
	if (currentBlock):
		remove_child(currentBlock)
	gameOverScreen.visible = false
	spawnNewBlock()
	
func pauseGame():
	if (pauseGameScreen.visible == true):
		Game.gamePaused = false
		pauseGameScreen.visible = false
		Game.pauseTimer()
	else:
		Game.gamePaused = true
		pauseGameScreen.visible = true
		Game.pauseTimer()
		

