extends TileMap

func placeBlocksOnTileMap(coords, color):
	for b in coords:
		var pos = world_to_map(b.global_position)
		set_cell(pos.x, pos.y, GlobalVariables.tiles[color])
	lineHandler()

func lineHandler():
	var rowsToBeDeleted = checkForLines()
	if (rowsToBeDeleted.size() > 0):
		var totalLines = rowsToBeDeleted.keys().size()
		deleteLines(rowsToBeDeleted)
		moveTilesDown(totalLines)

func checkForLines(): # Returns a dictionary of all complete lines
	var cells = get_used_cells()
	var completeLines = {}
	for row in range(19, 0, -1):
		var cellsInRow = getCellsInRow(cells, row)
		if (cellsInRow.size() == 10):
			completeLines[row] = cellsInRow
	return completeLines

func getCellsInRow(cells, rowNumber): # Gets cells in the given row
	var row = []
	for c in cells:
		if (c.y == rowNumber):
			row.append(c)
	return row

func deleteLines(rowsToBeDeleted):
	for rowNumber in rowsToBeDeleted.keys():
		for cell in rowsToBeDeleted[rowNumber]:
			set_cellv(cell, -1) # Deletes tile from tilemap

func moveTilesDown(lineCount):
	var remainingCells = get_used_cells()
	for cell in remainingCells:
		var blockType = get_cellv(cell)
		var newCoords = Vector2(cell.x, cell.y + lineCount)
		set_cellv(cell, -1)
		set_cellv(newCoords, blockType)

