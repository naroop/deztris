extends TileMap

onready var blockUtil = get_parent().get_node("BlocksUtil")
onready var pointsUI = get_parent().get_node("Background/Points")
onready var linesUI = get_parent().get_node("Background/Lines")
onready var levelUI = get_parent().get_node("Background/Level")

func placeBlocksOnTileMap(coords, color):
	for b in coords:
		var pos = world_to_map(b.global_position)
		set_cell(pos.x, pos.y, Game.TILES[color])
		if (pos.y == 0):
			Game.gameOver = true

func lineHandler(): # Returns a dictionary of all complete lines
	var linesGotten = 0
	var cells = get_used_cells()
	
	for line in range(20):
		var cellsInLine = getCellsInLine(cells, line)
	
		if (cellsInLine.size() == 10):
			linesGotten+=1
			deleteLine(cellsInLine)
			yield(get_tree().create_timer(0.09), "timeout") # buffer
			moveCellsAboveLine(line)
	
	if (linesGotten):
		print(linesGotten)
		updateLLAP(linesGotten)

func getCellsInLine(cells, lineNumber): # Gets cells in the given line
	var line = []
	for c in cells:
		if (c.y == lineNumber):
			line.append(c)
	return line

func deleteLine(cellsInLine):
	for cell in cellsInLine:
		set_cellv(cell, -1)

func moveCellsAboveLine(lineNumber):
	var potentialCells = get_used_cells()
	for cell in potentialCells: # copy to blocks util
		if (cell.y < lineNumber):
			copyCellToUtil(cell, false)
		else:
			copyCellToUtil(cell, true)
	utilToBlocks() # replace blocks with BU

func copyCellToUtil(cell, dontMoveDown):
	if (!dontMoveDown):
		blockUtil.set_cell(cell.x, cell.y + 1, get_cellv(cell))
	else:
		blockUtil.set_cell(cell.x, cell.y, get_cellv(cell))

func utilToBlocks():
	clear()
	var copiedBlocks = blockUtil.get_used_cells()
	for cell in copiedBlocks:
		set_cellv(cell, blockUtil.get_cellv(cell))
	blockUtil.clear()
	
func updateLLAP(lines):
	Game.lines += lines
	match lines:
		1:
			Game.points += 1 * Game.POINTS_MULTIPLIER * Game.level
		2:
			Game.points += 3 * Game.POINTS_MULTIPLIER * Game.level
		3:
			Game.points += 5 * Game.POINTS_MULTIPLIER * Game.level
		4:
			Game.points += 8 * Game.POINTS_MULTIPLIER * Game.level
			
	Game.setLevel()
	linesUI.set_text("Lines " + String(Game.lines))
	levelUI.set_text("Level " + String(Game.level))
	pointsUI.set_text("00000".substr(String(Game.points).length()) + String(Game.points))
	
	
