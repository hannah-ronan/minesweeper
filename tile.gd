extends Button


class_name tile
var is_mine
var mine_count
var x_loc
var y_loc
var label
var flagged
signal tile_clicked

var button_style = load("res://button.tres")
var button_flagged_style = load("res://button_flagged.tres")
	
func _init():
	self.x_loc = 0
	self.y_loc = 0
	self.is_mine = false
	self.mine_count = 0
	self.flagged = false


func pop():
	$AnimatedSprite.z_index = 10
	$AnimatedSprite.play("pop")
	$safe_sound.play()
func explode():
	$AnimatedSprite.z_index=10
	$AnimatedSprite.play("explode")
	$explode_sound.play()
func flag():
	$AnimatedSprite.z_index =10
	$AnimatedSprite.play("pop")
	$flag_sound.play()

func _on_Button_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		match event.button_index:
			BUTTON_LEFT:
				if !disabled:
					emit_signal("tile_clicked", x_loc, y_loc)
			BUTTON_RIGHT:
				if flagged == true:
					flagged = false
					self.add_stylebox_override("normal", button_style)
					self.add_color_override("font_color",Color("ff048b"))
					flag()
				else:
					flagged = true
					self.add_stylebox_override("normal", button_flagged_style)
					self.add_color_override("font_color",Color("e5003b"))
					flag()
