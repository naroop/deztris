extends TileMap

onready var BlocksUtil = get_parent().get_node("BlocksUtil")

func placeBlocksOnTileMap(coords, color):
	for b in coords:
		var pos = world_to_map(b.global_position)
		set_cell(pos.x, pos.y, GlobalVariables.tiles[color])

func lineHandler(): # Returns a dictionary of all complete lines
	var cells = get_used_cells()
	for line in range(20):
		var cellsInLine = getCellsInLine(cells, line)
		if (cellsInLine.size() == 10):
			deleteLine(cellsInLine) # delete all cells in that line
			yield(get_tree().create_timer(0.09), "timeout")
			moveCellsAboveLine(line) # move all cells above that line down one position

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
		BlocksUtil.set_cell(cell.x, cell.y + 1, get_cellv(cell))
	else:
		BlocksUtil.set_cell(cell.x, cell.y, get_cellv(cell))

func utilToBlocks():
	clear()
	var copiedBlocks = BlocksUtil.get_used_cells()
	for cell in copiedBlocks:
		set_cellv(cell, BlocksUtil.get_cellv(cell))
	BlocksUtil.clear()
