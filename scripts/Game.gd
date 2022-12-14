extends Node

const TILE_SIZE = 20
const POINTS_MULTIPLIER = 1
const BLOCKS = {
	"L1": "res://scenes/blocks/L1.tscn",
	"L2": "res://scenes/blocks/L2.tscn",
	"L": "res://scenes/blocks/L.tscn",
	"S": "res://scenes/blocks/S.tscn",
	"T": "res://scenes/blocks/T.tscn",
	"Z1": "res://scenes/blocks/Z1.tscn",
	"Z2": "res://scenes/blocks/Z2.tscn"
}
const TILES = {
	"yellow": 0,
	"purple": 1,
	"red": 2,
	"pink": 3,
	"blue": 4,
	"orange": 5,
	"green": 6
}
const BLOCK_COLORS = {
	"L1": "yellow",
	"L2": "purple",
	"L": "red",
	"S": "pink",
	"T": "blue",
	"Z1": "orange",
	"Z2": "green"
}

var inPlace: bool = false
var gameOver: bool  = false
var gamePaused: bool = false
var blockCoords: Array
var timer : Timer

var lines: int = 0
var points: int = 0
var level: int = 1
var blockStack: Array = []

func createTimer():
	timer = Timer.new()
	add_child(timer)
	var speed = pow((0.8 - ((level - 1) * 0.007)), level-1)
	timer.set_wait_time(speed)
	
func setLevel():
	Game.level = (lines / 10) + 1

func startTimer():
	timer.start()
	
func destroyTimer():
	timer.queue_free()
	
func pauseTimer():
	if (timer.is_paused()):
		timer.set_paused(false)
	elif (!timer.is_paused()):
		timer.set_paused(true)
	
func resetVariables():
	gamePaused = false
	inPlace = false
	gameOver = false
	blockCoords = []
	initBlockStack()
	lines = 0
	points = 0
	level = 1
	
func initBlockStack():
	blockStack.clear()
	blockStack.push_back(Game.BLOCKS.keys()[ randi() % Game.BLOCKS.size() ])
	
func getNewBlock(): # for the new block
	var b = blockStack.pop_front()
	blockStack.push_back(Game.BLOCKS.keys()[ randi() % Game.BLOCKS.size() ])
	print("Next block will be ... " + String(blockStack[0]))
	return b

func getNextBlock(): # for the next display
	return blockStack[0]
