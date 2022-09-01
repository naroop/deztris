extends Node2D

onready var tileMap = get_parent().get_node("Blocks")
var currentBlock: KinematicBody2D
var currentColor: String

# Called when the node enters the scene tree for the first time.
func _ready():
	spawnNewBlock()

func spawnNewBlock():
	GlobalVariables.inPlace = false
	GlobalVariables.createTimer()
	
	var blockName = GlobalVariables.blocks.keys()[ randi() % GlobalVariables.blocks.size() ]
	currentBlock = load(GlobalVariables.blocks[blockName]).instance()
	currentColor = GlobalVariables.blockColors[blockName]
	
	add_child(currentBlock)
	GlobalVariables.startTimer()

func _process(_delta):
	if (GlobalVariables.inPlace == true):
		GlobalVariables.destroyTimer()
		tileMap.placeBlocksOnTileMap(GlobalVariables.blockCoords, currentColor)
		remove_child(currentBlock)
		spawnNewBlock()


