extends Node2D

onready var tileMap = get_parent().get_node("Blocks")
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
	get_tree().quit()


