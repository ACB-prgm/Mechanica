extends EditorProperty
class_name KeepCenteredProperty


var checkbox = CheckBox.new()
var edited_control = null
var has_refreshed = false


func _init():
	set_physics_process(false)
	label = "Keep Pivot Offset Centered"
	
	checkbox.connect("toggled", self, "_on_checkbox_checked")
	add_child(checkbox)


func _on_checkbox_checked(is_checked):
	edited_control = get_edited_object()
	emit_changed("Keep_Centered", is_checked)
	set_physics_process(is_checked)


func _physics_process(delta):
	if edited_control:
		edited_control.rect_pivot_offset = edited_control.rect_size/2.0
		edited_control.rect_size = Vector2(0,0)


func update_property():
	if !has_refreshed:
		has_refreshed = true
		
		edited_control = get_edited_object()
		if edited_control:
			if edited_control[get_edited_property()] == edited_control.rect_size/2.0: #pivot offset is centered
				set_physics_process(true)
				checkbox.set_pressed(true)
