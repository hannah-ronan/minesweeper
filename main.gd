extends Node2D
var game = load("res://game.gd")
onready var menu = get_node("main_ui")
func on_ready():
	randomize()

func _on_small_pressed():
	menu.visible=false
	var small_game = game.new()
	small_game.size = 10
	small_game.create_grid()


func _on_medium_pressed():
	menu.visible=false
	var medium_game = game.new()
	medium_game.size = 20
	medium_game.create_grid()


func _on_large_pressed():
	menu.visible=false
	var large_game = game.new()
	large_game.size = 30
	large_game.create_grid()
