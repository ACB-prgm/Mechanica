extends EditorProperty
class_name KeepCenteredProperty


var checkbox = CheckBox.new()
var edited_control = null
var current_value = false


func _init():
#	var container = HBoxContainer.new()
#	add_child(container)
#
#	var _label = Label.new()
#	_label.text = "Keep Centered"
#	container.add_child(_label)
	label = "Keep Pivot Offset Centered"
	
	checkbox.connect("toggled", self, "_on_checkbox_checked")
	add_child(checkbox)


func _on_checkbox_checked(is_checked):
	edited_control = get_edited_object()
	current_value = is_checked
	emit_changed("Keep_Centered", is_checked)
	set_physics_process(is_checked)

func _physics_process(delta):
	if edited_control:
		edited_control.rect_pivot_offset = edited_control.rect_size/2.0
		edited_control.rect_size = Vector2(0,0)


#func update_property():
#	var new_value = get_edited_object()[get_edited_property()]
#	if (new_value == current_value):
#		return
#
#	current_value = new_value
#	checkbox.set_pressed(current_value)
