extends GridContainer

class_name game
var tiles = []
var tile_class = load("res://tile.tscn")
var size = 10


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
				tile.text = str(tile.mine_count)
"""
this is a dumb way of counting mines
func update_corners():
	#define which tiles are corners 
	for row in tiles:
		for tile in row:
			if tile.x_loc == 0 or tile.x_loc ==(size-1) or tile.y_loc == 0 or tile.y_loc ==(size-1):
				tile.is_edge = true
				if tile.y_loc == 0:
					tile.edge_id += "top"
				if tile.y_loc == (size-1):
					tile.edge_id += "bottom"
				if tile.x_loc == 0:
					tile.edge_id += "left"
				if tile.x_loc == (size-1):
					tile.edge_id += "right"
				
				if (tile.x_loc==0 and tile.y_loc==0)or (tile.x_loc==0 and tile.y_loc==(size-1))or(tile.x_loc==(size-1) and tile.y_loc==0)or(tile.x_loc==(size-1) and tile.y_loc==(size-1)):
					tile.is_corner = true

func update_numbers():
	#loop through all tiles in the grid to check how many mines are around them and update the tiles array 
	for row in tiles:
		for tile in row:
			if !tile.is_mine:	
				if !tile.is_corner and !tile.is_edge:
					check_all(tile)
				elif tile.is_corner:
					check_corner(tile)
				elif tile.is_edge:
					check_edge(tile)
				tile.text = str(tile.mine_count)
			else:
				tile.text = "X"
func check_all(tile):
	check_tile(tile, -1,-1)
	check_tile(tile, 0,-1)
	check_tile(tile, 1,-1)
	check_tile(tile, -1,0)
	check_tile(tile, 1,0)
	check_tile(tile, -1,1)
	check_tile(tile, 0,1)
	check_tile(tile, 1,1)
	
func check_edge(tile):
	if tile.edge_id=="right":
		check_tile(tile, 0,-1)
		check_tile(tile, -1,-1)
		check_tile(tile, -1,0)
		check_tile(tile, -1,1)
		check_tile(tile, 0,1)
		
	if tile.edge_id=="left":
		check_tile(tile, 0,-1)
		check_tile(tile, 1,-1)
		check_tile(tile, 1,0)
		check_tile(tile, 1,1)
		check_tile(tile, 0,1)
		
	if tile.edge_id=="top":
		check_tile(tile, -1,0)
		check_tile(tile, -1,1)
		check_tile(tile, 0,1)
		check_tile(tile, 1,1)
		check_tile(tile, 1,0)
		
	if tile.edge_id=="bottom":
		check_tile(tile, -1,0)
		check_tile(tile, -1,-1)
		check_tile(tile, 0,-1)
		check_tile(tile, 1,-1)
		check_tile(tile, 1,0)

func check_corner(tile):
	if tile.edge_id=="topright":
		check_tile(tile, -1,0)
		check_tile(tile, -1,1)
		check_tile(tile, 0,1)
	if tile.edge_id=="bottomright":
		check_tile(tile, -1,0)
		check_tile(tile, -1,-1)
		check_tile(tile, 0,-1)
	if tile.edge_id=="topleft":
		check_tile(tile, 1,0)
		check_tile(tile, 1,1)
		check_tile(tile, 0,1)
	if tile.edge_id=="bottomleft":
		check_tile(tile, 0,-1)
		check_tile(tile, 1,-1)
		check_tile(tile, 1,0)
	
func check_tile(tile, xoffset, yoffset):
	if tiles[tile.x_loc+xoffset][tile.y_loc+yoffset].is_mine:
		tile.mine_count +=1
"""

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
				tile.text = "X"
				tile.add_color_override("font_color", Color(1,0,0,1))



func tile_check(tile,xoffset,yoffset):
	#checks to see if the tile exists and if it does then increment its minecount
	if (tile.x_loc+xoffset)>=0 and (tile.y_loc+yoffset)>=0 and (tile.x_loc+xoffset)<=(size-1) and (tile.y_loc+yoffset)<=(size-1):
		if !tiles[tile.x_loc+xoffset][tile.y_loc+yoffset].is_mine:
			tiles[tile.x_loc+xoffset][tile.y_loc+yoffset].mine_count += 1
				
				
				
