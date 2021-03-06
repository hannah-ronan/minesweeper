extends Label

class_name tile
var is_mine
var mine_count
var x_loc
var y_loc
var is_corner
var is_edge
var edge_id
var label
var size
#var mask = Label.new()

func _init():
	self.x_loc = 0
	self.y_loc = 0
	self.is_mine = false
	self.is_corner = false
	self.is_edge = false
	self.edge_id = ""
	self.mine_count = 0
	self.size = 10

	
