extends Button

class_name tile
var is_mine
var mine_count
var x_loc
var y_loc
var is_corner
var is_edge
var edge_id
var label

func _init():
	self.x_loc = 0
	self.y_loc = 0
	self.is_mine = false
	self.mine_count = 0

	


func _on_Button_pressed():
	print(is_mine)

