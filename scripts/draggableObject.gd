#@tool
extends Node2D
#TODO get this shit done and be happy
#@export var texture : Texture : set = _set_texture, get = _get_texture
#
#func _process(delta):
#	if Engine.is_editor_hint():
#		var bttn : Button
#		var sprite : Sprite2D

		


#		func _set_texture(new_texture : Texture) -> void:
#			texture = new_texture
#			sprite.set_texture(texture)
#			bttn.set_anchors_preset(Control.PRESET_FULL_RECT,true)

#		func _get_texture() -> Texture:
#			return texture

var dragging = false
var offest = Vector2(0,0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if dragging:
		position = get_global_mouse_position() - offest

func _on_button_button_down():
	dragging = true
	offest = get_global_mouse_position() - global_position


func _on_button_button_up():
	dragging = false
