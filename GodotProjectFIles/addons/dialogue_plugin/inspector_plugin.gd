extends EditorInspectorPlugin


func can_handle(object):
	return true

func parse_begin(object):
	if object.has_method("_on_dialogue_option_selected"):
		
		var Dialogue_label = Label.new()
		Dialogue_label.set_text("Dialogue")
		Dialogue_label.set_align(1)
		add_custom_control(Dialogue_label)
		
		var dropdown = OptionButton.new()
		for key in Dialogue.load_dialogue_info().keys():
			dropdown.add_item(key)
		dropdown.connect("item_selected", object, "_on_dialogue_option_selected")
		add_custom_control(dropdown)
		object.dropdown = dropdown
		
		var Preview_label = Label.new()
		Preview_label.set_text("Preview")
		Preview_label.set_align(1)
		add_custom_control(Preview_label)
		
		var preview = Label.new()
		object.dialogue_preview = preview
		add_custom_control(preview)
		
		if object.has_method("load_dialogue_data"):
			object.load_dialogue_data()
