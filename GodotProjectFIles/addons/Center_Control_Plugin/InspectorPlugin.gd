extends EditorInspectorPlugin


func can_handle(object):
	return object is Control


func parse_property(object, type, path, hint, hint_text, usage):
	if path == "rect_pivot_offset":
		add_property_editor(path, KeepCenteredProperty.new())


