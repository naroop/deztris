extends Node

var tileSize = 20
var tickSpeed = 1
var inPlace = false
var blockCoords: Array

var blocks = {
	"L1": "res://scenes/blocks/L1.tscn",
	"L2": "res://scenes/blocks/L2.tscn",
	"L": "res://scenes/blocks/L.tscn",
	"S": "res://scenes/blocks/S.tscn",
	"T": "res://scenes/blocks/T.tscn",
	"Z1": "res://scenes/blocks/Z1.tscn",
	"Z2": "res://scenes/blocks/Z2.tscn"
}

var tiles = {
	"yellow": 0,
	"purple": 1,
	"red": 2,
	"pink": 3,
	"blue": 4,
	"orange": 5,
	"green": 6
}

var blockColors = {
	"L1": "yellow",
	"L2": "purple",
	"L": "red",
	"S": "pink",
	"T": "blue",
	"Z1": "orange",
	"Z2": "green"
}

var timer : Timer = null

func createTimer():
	timer = Timer.new()
	add_child(timer)
	timer.set_wait_time(GlobalVariables.tickSpeed)

func startTimer():
	timer.start()
	
func destroyTimer():
	timer.queue_free()
