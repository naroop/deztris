extends TileMap

func placeBlocksOnTileMap(coords, color):
	for b in coords:
		var pos = world_to_map(b.global_position)
		set_cell(pos.x, pos.y, GlobalVariables.tiles[color])
