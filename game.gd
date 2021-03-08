extends GridContainer

class_name game
var tiles = []
var tile_class = load("res://tile.tscn")
var size = 10
signal game_over
signal game_won

	
func create_grid():
	#create the game grid, filled only with 0s then populate it with mines
	#the grid gets size*1.5 mines on it
	randomize()#this is here so the board is different every time
	for y in range(size):
		tiles.append([])
		for x in range(size):
			var new_tile = tile_class.instance()
			new_tile.x_loc = x
			new_tile.y_loc = y
			tiles[y].append(new_tile)
			new_tile.set_name(str(x)+", "+str(y))#change the nodes name to be its location in the grid
			new_tile.connect("tile_clicked",self, "tile_clicked")#connect the signal that gets sent from the tile object
			
	var mines_placed = 0
	while mines_placed<(floor(size*1.5)):
		#place 1.5x the size of the grid number of mines into the game
		var randx = randi() % size
		var randy = randi() % size
		for row in tiles:
			for tile in row:
				if tile.x_loc == randx and tile.y_loc==randy and tile.is_mine==false:
					tile.is_mine = true
					mines_placed+=1
	mine_tally()#update the mine_count of each tile then display this count in the game
	for row in tiles:
		for tile in row:
			if !tile.is_mine:
				if tile.mine_count != 0:
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
		tile_check("count_check",tile,-1,-1)
		tile_check("count_check",tile,0,-1)
		tile_check("count_check",tile,1,-1)
		tile_check("count_check",tile,-1,0)
		tile_check("count_check",tile,1,0)
		tile_check("count_check",tile,-1,1)
		tile_check("count_check",tile,0,1)
		tile_check("count_check",tile,1,1)
	
func tile_check(mode,tile,xoffset,yoffset):
	#checks to see if the tile exists
	var new_x = tile.x_loc+xoffset
	var new_y = tile.y_loc+yoffset
	if (new_x)>=0 and (new_y)>=0 and (new_x)<=(size-1) and (new_y)<=(size-1):
		#found the bug with mine_count being off... the tiles array is in the format tiles[y][x] not tiles[x][y] as I had before >:(
		if mode == "count_check":
			#if the tile and its adjacent tile is also equal to 0 then reveal it
			if tile.mine_count==0:
				if tiles[new_y][new_x].mine_count == tile.mine_count and !tiles[new_y][new_x].disabled:
					tiles[new_y][new_x].disabled = true
					check_adj_tiles(tiles[new_y][new_x])
				elif !tiles[new_y][new_x].disabled and !tiles[new_y][new_x].is_mine:
					tiles[new_y][new_x].disabled = true
			
		if mode=="mine_check":
			#id the adjacent tile is a mine then increment its minecount
			if !tiles[new_y][new_x].is_mine:
				tiles[new_y][new_x].mine_count += 1

func tile_clicked(x_loc,y_loc):
	#function called when game receives the signal emitted from the tile node that it had been clicked
	tiles[y_loc][x_loc].disabled = true
	check_adj_tiles(tiles[y_loc][x_loc])
	if tiles[y_loc][x_loc].is_mine:
		emit_signal("game_over", self)
	else:
		tiles[y_loc][x_loc].pop()
		check_for_win()

func check_for_win():
	#if all the non-mine tiles are revealed then the game is won, send the signal out to main
	var revealed_tiles = 0
	var mines = 0
	for row in tiles:
		for tile in row:
			if tile.disabled:
				revealed_tiles +=1
			elif tile.is_mine:
				mines += 1
	if mines + revealed_tiles == size*size:
		print ("game won")
		emit_signal("game_won",self)
