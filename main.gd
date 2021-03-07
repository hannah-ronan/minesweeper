extends Node2D
var game_class = load("res://game.tscn")
onready var menu = get_node("main_menu")
onready var quit_button = get_node("in_game_controls/quit_button")
onready var lose_message = get_node("in_game_controls/loser")
onready var win_message = get_node("in_game_controls/winner")

func _on_small_pressed():
	menu.visible=false
	var small_game = game_class.instance()
	small_game.create_grid()
	small_game.columns = 10
	small_game.size = 10
	get_node("center_container").add_child(small_game)
	get_node("center_container/game").connect("game_over",self, "game_over")
	get_node("center_container/game").connect("game_won",self, "game_won")
	draw_grid(small_game)
	quit_button.disabled = false

func _on_big_pressed():
	menu.visible=false
	var medium_game = game_class.instance()
	medium_game.columns = 15
	medium_game.size = 15
	medium_game.create_grid()
	get_node("center_container").add_child(medium_game)
	get_node("center_container/game").connect("game_over",self, "game_over")
	get_node("center_container/game").connect("game_won",self, "game_won")
	draw_grid(medium_game)
	quit_button.disabled = false

"""
func _on_large_pressed():
	menu.visible=false
	var large_game = game_class.instance()
	large_game.columns = 20
	large_game.size = 20
	large_game.create_grid()
	get_node("center_container").add_child(large_game)
	draw_grid(large_game)
	quit_button.disabled = false
"""
	
func draw_grid(grid):
	for row in grid.tiles:
		for tile in row:
			grid.add_child(tile)

func _on_quit_button_pressed():
	get_node("center_container/game").queue_free()
	menu.visible = true
	quit_button.disabled = true
	lose_message.visible = false

func game_over(game_instance):
	for row in game_instance.tiles:
		for tile in row:
			if tile.is_mine:
				tile.set("custom_colors/font_color_disabled", Color(1,0,0))
			tile.disabled = true
	lose_message.visible = true

func game_won(game_instance):
	for row in game_instance.tiles:
		for tile in row:
			if tile.is_mine:
				tile.set("custom_colors/font_color_disabled", Color(1,0,0))
			tile.disabled = true
	win_message.visible = true
