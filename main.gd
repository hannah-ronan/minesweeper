extends Node2D
var game_class = load("res://game.tscn")
onready var menu = get_node("menu")


func on_ready():
	pass

func _on_small_pressed():
	menu.visible=false
	var small_game = game_class.instance()
	small_game.create_grid()
	small_game.columns = 10
	add_child(small_game)
	draw_grid(small_game)

func _on_medium_pressed():
	menu.visible=false
	var medium_game = game_class.instance()
	medium_game.columns = 20
	medium_game.size = 20
	medium_game.create_grid()
	add_child(medium_game)
	draw_grid(medium_game)


func _on_large_pressed():
	menu.visible=false
	var large_game = game_class.instance()
	large_game.columns = 30
	large_game.size = 30
	large_game.create_grid()
	add_child(large_game)
	draw_grid(large_game)

func draw_grid(grid):
	for row in grid.tiles:
		for tile in row:
			grid.add_child(tile)
			
	
