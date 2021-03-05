extends Node2D

class_name game
var tiles = []
var tile = load("res://tile.gd")
var size = 0
func create_grid():
	#create the game grid, filled only with 0s then populate it with mines
	#the grid gets size*2 mines on it
	for y in range(size):
		tiles.append([])
		for x in range(size):
			var new_tile = tile.new()
			tiles[y].append(new_tile)
			new_tile.x_loc = x
			new_tile.y_loc = y
			
	var mine_count = 0
	while mine_count<(size*3):
		var randx = randi() % tiles.size()
		var randy = randi() % tiles.size()
		for row in tiles:
			for tile in row:
				if tile.x_loc == randx and tile.y_loc==randy:
					tile.is_mine = true
					mine_count+=1
	update_corners()
	update_numbers()

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
			if !tile.is_corner and !tile.is_edge:
				check_all(tile)
			elif tile.is_corner:
				check_corner(tile)
			elif tile.is_edge:
				check_edge(tile)
				
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
	
