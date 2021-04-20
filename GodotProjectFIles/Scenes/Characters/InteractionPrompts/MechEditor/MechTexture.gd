tool
extends TextureRect


export var _texture: StreamTexture setget change_mech_texture


func change_mech_texture(new_texture):
	_texture = new_texture
	texture = new_texture
	rect_pivot_offset = rect_size/2.0
