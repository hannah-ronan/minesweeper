extends GridContainer

class_name game
var tiles = []
var tile_class = load("res://tile.tscn")
var size = 10
signal game_over
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
		adj_tiles.append(tiles[y_loc+yoffset][x_loc+xoffset])
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
			else:
				tile.text = " X "

func mine_tally():
	for row in tiles:
		for tile in row:
			if tile.is_mine:
				tile_check("mine_check",tile,-1,-1)
				tile_check("mine_check",tile,0,-1)
				tile_check("mine_check",tile,1,-1)
				tile_check("mine_check",tile,-1,0)
				tile_check("mine_check",tile,1,0)
				tile_check("mine_check",tile,-1,1)
				tile_check("mine_check",tile,0,1)
				tile_check("mine_check",tile,1,1)
				
func check_adj_tiles(tile):
	if !tile.is_mine:
		tile_check("count_check",tile,0,-1)
		tile_check("count_check",tile,-1,0)
		tile_check("count_check",tile,1,0)
		tile_check("count_check",tile,0,1)
	
func tile_check(mode,tile,xoffset,yoffset):
	#checks to see if the tile exists and if it does then increment its minecount
	var new_x = tile.x_loc+xoffset
	var new_y = tile.y_loc+yoffset
	if (new_x)>=0 and (new_y)>=0 and (new_x)<=(size-1) and (new_y)<=(size-1):
		#found the bug with mine_count being off... the tiles array is in the format tiles[y][x] not tiles[x][y] as I had before >:(
		if mode == "count_check":
			if tiles[new_y][new_x].mine_count == tile.mine_count and !tiles[new_y][new_x].disabled:
				tiles[new_y][new_x].disabled = true
				check_adj_tiles(tiles[new_y][new_x])
		if mode=="mine_check":
			if !tiles[new_y][new_x].is_mine:
				tiles[new_y][new_x].mine_count += 1

func tile_clicked(x_loc,y_loc):
	#function called when game receives the signal emitted from the tile node that it had been clicked
	tiles[y_loc][x_loc].disabled = true
	check_adj_tiles(tiles[y_loc][x_loc])
	if tiles[y_loc][x_loc].is_mine:
		emit_signal("game_over", self)

	
