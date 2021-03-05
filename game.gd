extends Node2D

class_name game


static func create_grid(size):
	#create the game grid, filled only with 0's
	#use the place_mines function to recursively populate the grid with mines
	#the size dictages the number of mines and the size of the grid
	#grid dimensions: size x size
	var tiles = []
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
	print (tiles)
	print (mine_count)
		

		
		
