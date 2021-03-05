extends Node2D

class_name game
var tiles = []

func create_grid(size):
	#create the game grid, filled only with 0s then populate it with mines
	#the grid gets size*2 mines on it
	for x in range(size):
		tiles.append([])
		for y in range(size):
			tiles[x].append(0)
	var mine_count = 0
	while mine_count<(size*2):
		var randx = randi() % tiles.size()
		var randy = randi() % tiles.size()
		if tiles[randx][randy] != -1:
			tiles[randx][randy] = -1
			mine_count += 1
	grid_numbers(size)

func grid_numbers(size):
	for x in range (tiles.size()):
		for y in range (tiles.size()):
			#loop through all tiles in the grid to check how many mines are around them and update the tiles array 
			if tiles[x][y] != -1:
				#if the tile is not a mine
				if x!=0 and x!=(size-1) and y!=0 and y!=(size-1):
					#if the current tile is not on the edge of the grid
					check_below_tiles(x,y)
					check_beside_tiles(x,y)
					check_above_tiles(x,y)
				elif x==0:
					#if the tile is in the top row
					if y!=0 and y!=(size-1):
						#if the tile is in the top row but not either corner
						check_below_tiles(x,y)
						check_beside_tiles(x,y)
					else:
						#if the tile is in one of the top corners
						if y==0:
							#if the tile is in the top left corner
							check_tile(x,y,0,1)#check to the right
							check_tile(x,y,1,0)#check to the bottom
							check_tile(x,y,1,1)#check to the lower right
						else:
							#if the tile is in the top right corner
							check_tile(x,y,0,-1)#check to the left
							check_tile(x,y,1,0)#check to the bottom
							check_tile(x,y,1,-1)#check to the lower left
						
				elif x==(size-1):
					if y!=0 and y!=(size-1):
						#if the tile is in the top row but not either corner
						check_above_tiles(x,y)
						check_beside_tiles(x,y)
					else:
						#if the tile is in one of the bottom corners
						if y==0:
							#if the tile is in the bottom left corner
							check_tile(x,y,0,1)#check to the right
							check_tile(x,y,-1,0)#check to the top
							check_tile(x,y,-1,1)#check to the upper right
						else:
							#if the tile is in the bottom right corner
							check_tile(x,y,0,-1)#check to the left
							check_tile(x,y,-1,0)#check to the top
							check_tile(x,y,-1,-1)#check to the upper left
				elif y==0:
					#if the tile is on the left edge
					check_tile(x,y,-1,0)
					check_tile(x,y,-1,1)
					check_tile(x,y,0,1)
					check_tile(x,y,1,1)
					check_tile(x,y,1,0)
				elif y==(size-1):
					#if the tile is on the right edge
					check_tile(x,y,-1,0)
					check_tile(x,y,-1,-1)
					check_tile(x,y,0,-1)
					check_tile(x,y,1,-1)
					check_tile(x,y,1,0)
			
func check_above_tiles(x,y):
	#check if the 3 tiles above the current tile are mines
	check_tile(x,y,-1,-1)
	check_tile(x,y,-1,0)
	check_tile(x,y,-1,1)

func check_beside_tiles(x,y):
	#check if the 2 tiles on either side of the current tile are mines
	check_tile(x,y,0,-1)
	check_tile(x,y,0,+1)

func check_below_tiles(x,y):
	#check if the 3 tiles below the current tile are mines
	check_tile(x,y,1,-1)
	check_tile(x,y,1,0)
	check_tile(x,y,1,1)
	
func check_tile(x,y,xoffset, yoffset):
	if tiles[x+xoffset][y+yoffset] == -1:
		tiles[x][y]+=1
