extends Node2D
var game = load("res://game.gd")
func on_ready():
	randomize()

func _on_small_pressed():
	var small_game = game.new()
	small_game.size = 10
	small_game.create_grid()


func _on_medium_pressed():
	var medium_game = game.new()
	medium_game.size = 20
	medium_game.create_grid()


func _on_large_pressed():
	var large_game = game.new()
	large_game.size = 30
	large_game.create_grid()
