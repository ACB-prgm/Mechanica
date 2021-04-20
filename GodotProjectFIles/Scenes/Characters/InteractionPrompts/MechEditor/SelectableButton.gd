tool
extends Label

const GLOW_COLOR = Color(1, 1, 1.2, 1.2)
const REG_COLOR = Color(1, 1, 1.2, 1.15)
const CURSOR_START_POS = Vector2(-10, 6)

onready var cursor = $TextureRect
onready var animationPlayer = $AnimationPlayer

var is_pressed:bool = false

signal selected(_text)


func _ready():
	cursor.hide()


func _physics_process(_delta):
	if Engine.editor_hint:
		rect_pivot_offset = rect_size/2.0
		rect_size = Vector2(0,0)
	else:
		set_physics_process(false)


func _on_Button_mouse_entered():
	if !is_pressed:
		modulate = GLOW_COLOR
		cursor.show()
		animationPlayer.play("IconBob")



func _on_Button_mouse_exited():
	if !is_pressed:
		modulate = Color(1,1,1,1)
		cursor.hide()
		animationPlayer.stop(true)



#func _on_Button_toggled(button_pressed):
#	is_pressed = button_pressed
#
#	if button_pressed:
#		emit_signal("selected", text)
#	else:
#		_on_Button_mouse_exited()


func _on_SelectableButton_focus_entered():
	emit_signal("selected", text)
	PopupLayer.last_focused = self
	if !is_pressed:
		modulate = GLOW_COLOR
		cursor.show()
		animationPlayer.play("IconBob")


func _on_SelectableButton_focus_exited():
	if !is_pressed:
		modulate = Color(1,1,1,1)
		cursor.hide()
		animationPlayer.stop(true)
