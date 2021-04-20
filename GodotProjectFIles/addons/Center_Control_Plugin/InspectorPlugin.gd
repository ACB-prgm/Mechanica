extends EditorInspectorPlugin


var controls = {}


func can_handle(object):
#	if object.has_method("_print"):
#		object._print(object.get_property_list())
	return object is Control


func parse_property(object, type, path, hint, hint_text, usage):
	if path == "rect_pivot_offset":
		add_property_editor(path, KeepCenteredProperty.new())


