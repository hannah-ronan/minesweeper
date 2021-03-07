extends GridContainer

class_name game
var tiles = []
var tile_class = load("res://tile.tscn")
var size = 10
#onready var main = get_owner()
"""
#debug tools, tile_clicked gets called whenever a tile is clicked, imagine that, and gets passed the tiles x and y in the tiles array
func tile_clicked(x_loc, y_loc):
	var adj_tiles = []
	adj_tiles = add_adj_tiles(-1,-1, adj_tiles,x_loc, y_loc)
	adj_tiles = add_adj_tiles(0,-1, adj_tiles,x_loc, y_loc)
	adj_tiles = add_adj_tiles(1,-1, adj_tiles,x_loc, y_loc)
	
	adj_tiles = add_adj_tiles(-1,0, adj_tiles,x_loc, y_loc)
	adj_tiles = add_adj_tiles(1,0, adj_tiles,x_loc, y_loc)
	
	adj_tiles = add_adj_tiles(-1,1, adj_tiles,x_loc, y_loc)
	adj_tiles = add_adj_tiles(0,1, adj_tiles,x_loc, y_loc)
	adj_tiles = add_adj_tiles(1,1, adj_tiles,x_loc, y_loc)
	
	for adj_tile in adj_tiles:
		print (adj_tile.x_loc," ", adj_tile.y_loc," ",adj_tile.is_mine)
	
func add_adj_tiles(xoffset,yoffset, adj_tiles,x_loc, y_loc):
	#checks to see if the tile exists and if it does then increment its minecount
	if (x_loc+xoffset)>=0 and (y_loc+yoffset)>=0 and (x_loc+xoffset)<=(9) and (y_loc+yoffset)<=(9):
		adj_tiles.append(tiles[x_loc+xoffset][y_loc+yoffset])
	return adj_tiles
"""

	
func create_grid():
	#create the game grid, filled only with 0s then populate it with mines
	#the grid gets size*3 mines on it
	randomize()#this is here so the board is different every time
	for y in range(size):
		tiles.append([])
		for x in range(size):
			var new_tile = tile_class.instance()
			new_tile.x_loc = x
			new_tile.y_loc = y
			tiles[y].append(new_tile)
			new_tile.set_name(str(x)+", "+str(y))
			new_tile.connect("tile_clicked",self, "tile_clicked")
			
	var mines_placed = 0
	while mines_placed<(size*3):
		#place 3X the size of the grid number of mines into the game
		var randx = randi() % size
		var randy = randi() % size
		for row in tiles:
			for tile in row:
				if tile.x_loc == randx and tile.y_loc==randy and tile.is_mine==false:
					tile.is_mine = true
					mines_placed+=1
	mine_tally()
	for row in tiles:
		for tile in row:
			if !tile.is_mine:
				tile.text = " "+str(tile.mine_count)+" "


func mine_tally():
	for row in tiles:
		for tile in row:
			if tile.is_mine:
				tile_check(tile,-1,-1)
				tile_check(tile,0,-1)
				tile_check(tile,1,-1)
				tile_check(tile,-1,0)
				tile_check(tile,1,0)
				tile_check(tile,-1,1)
				tile_check(tile,0,1)
				tile_check(tile,1,1)
				tile.text = " X "

func tile_check(tile,xoffset,yoffset):
	#checks to see if the tile exists and if it does then increment its minecount
	if (tile.x_loc+xoffset)>=0 and (tile.y_loc+yoffset)>=0 and (tile.x_loc+xoffset)<=(size-1) and (tile.y_loc+yoffset)<=(size-1):
		#found the bug with mine_count being off... the tiles array is in the format tiles[y][x] not tiles[x][y] as I had before >:(
		if !tiles[tile.y_loc+yoffset][tile.x_loc+xoffset].is_mine:
			tiles[tile.y_loc+yoffset][tile.x_loc+xoffset].mine_count += 1

func tile_clicked(x_loc,y_loc):
	#function called when game receives the signal emitted from the tile node that it had been clicked
	tiles[y_loc][x_loc].disabled = true

	
