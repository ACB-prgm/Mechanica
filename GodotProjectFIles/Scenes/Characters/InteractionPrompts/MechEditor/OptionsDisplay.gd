tool
extends TextureRect


export var title: String = "Default Title" setget set_title
export var options = PoolStringArray() setget set_options

var buttonTSCN = preload("res://Scenes/Characters/InteractionPrompts/MechEditor/SelectableButton.tscn")

signal item_selected(item)


func _ready():
	if !Engine.editor_hint:
		var child_0 = $OptionsContainer.get_child(0)
		child_0.focus_neighbour_top = self.get_path()
		focus_neighbour_bottom = child_0.get_path()

func _physics_process(_delta):
	if Engine.editor_hint:
		$Title.rect_pivot_offset = $Title.rect_size/2.0
		$Title.rect_size = Vector2(0,0)
	else:
		set_physics_process(false)


func set_options(new_values):
	options = new_values
	
	if $OptionsContainer.get_children():
		for child in $OptionsContainer.get_children():
			$OptionsContainer.remove_child(child)
	
	for option in new_values:
		var ins_button = buttonTSCN.instance()
		ins_button.text = option
		ins_button.connect("selected", self, "_on_button_selected")
		$OptionsContainer.add_child(ins_button)


func set_title(new_value):
	title = new_value
	$Title.set_text("[ %s ]" % new_value)


func _on_button_selected(text):
	emit_signal("item_selected", text)


func _on_OptionsDisplay_focus_entered():
	if PopupLayer.last_focused == get_node(focus_neighbour_top):
		$OptionsContainer.get_child(0).grab_focus()
	elif PopupLayer.last_focused == get_node(focus_neighbour_bottom):
		get_node(focus_neighbour_top).grab_focus()
