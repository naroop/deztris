extends Sprite

var currentlyShowing: Sprite

func setNextBlock(nextBlock: String):
	var block = get_node(nextBlock)
	showAndHideBlocks(block, currentlyShowing)
	currentlyShowing = block

func showAndHideBlocks(show: Sprite, hide: Sprite):
	if (show == hide):
		show.visible = true
		return
	
	if (show):
		show.visible = true
	if (hide):
		hide.visible = false
