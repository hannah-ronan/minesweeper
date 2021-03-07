extends Node2D
var game_class = load("res://game.tscn")
onready var menu = get_node("main_menu")
onready var quit_button = get_node("in_game_controls/quit_button")
onready var lose_message = get_node("in_game_controls/loser")
onready var win_message = get_node("in_game_controls/winner")
onready var flag_instructions = get_node("flag_instructions")

func _on_small_pressed():
	#when the small size is chosen create a 10 by 10 grid and hide the main menu
	menu.visible=false
	var small_game = game_class.instance()
	small_game.create_grid()
	small_game.columns = 10
	small_game.size = 10
	get_node("center_container").add_child(small_game)
	#connect the game won/lost signals 
	get_node("center_container/game").connect("game_over",self, "game_over")
	get_node("center_container/game").connect("game_won",self, "game_won")
	draw_grid(small_game)
	quit_button.disabled = false
	flag_instructions.visible = true

func _on_big_pressed():
	#when the big size button is chosen create a 15x15 grid and hide the menu
	menu.visible=false
	var medium_game = game_class.instance()
	medium_game.columns = 15
	medium_game.size = 15
	medium_game.create_grid()
	get_node("center_container").add_child(medium_game)
	#connect the game won/lost signals from game
	get_node("center_container/game").connect("game_over",self, "game_over")
	get_node("center_container/game").connect("game_won",self, "game_won")
	draw_grid(medium_game)
	quit_button.disabled = false
	flag_instructions.visible = true

	
func draw_grid(grid):
	#add the tiles to the gridcontainer
	for row in grid.tiles:
		for tile in row:
			grid.add_child(tile)

func _on_quit_button_pressed():
	#when quit is pressed delete all the tiles then the grid
	for child in get_node("center_container/game").get_children():
		child.queue_free()
	get_node("center_container/game").queue_free()
	#show the menu and get rid of the quit button and win/lose messages
	menu.visible = true
	quit_button.disabled = true
	lose_message.visible = false
	win_message.visible = false
	flag_instructions.visible = false

func game_over(game_instance):
	#called when a mine is clicked, show the whole grid and set the mine text color to red
	for row in game_instance.tiles:
		for tile in row:
			if tile.is_mine:
				tile.set("custom_colors/font_color_disabled", Color(1,0,0))
			tile.disabled = true
	lose_message.visible = true

func game_won(game_instance):
	#called when the game is won, show the whole grid and make the mines red
	for row in game_instance.tiles:
		for tile in row:
			if tile.is_mine:
				tile.set("custom_colors/font_color_disabled", Color(1,0,0))
			tile.disabled = true
	win_message.visible = true
