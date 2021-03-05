extends Node2D
var game = load("res://game.gd")
func on_ready():
	randomize()

func _on_small_pressed():
	var small_game = game.new()
	small_game.create_grid(10)


func _on_medium_pressed():
	pass # Replace with function body.


func _on_large_pressed():
	pass # Replace with function body.
