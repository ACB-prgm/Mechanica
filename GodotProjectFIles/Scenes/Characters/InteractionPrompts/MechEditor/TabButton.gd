tool
extends Label

export var tab_control = 1

onready var tween = $Tween
onready var leftBracket = $LeftBracket
onready var rightBracket = $RightBracket
onready var rightBracket_start = Vector2(rect_size.x + 12, -23)
onready var leftBracket_end = leftBracket_start + Vector2(-100, 0)
onready var rightBracket_end = rightBracket_start + Vector2(100, 0)

var leftBracket_start = Vector2(-50, -23) 
var selected = false

signal TabButtonPressed(button)


func _ready():
	leftBracket.rect_position = leftBracket_end
	rightBracket.rect_position = rightBracket_end


func _physics_process(_delta):
	if Engine.editor_hint:
		rect_pivot_offset = rect_size/2.0
		rect_size = Vector2(0,0)
	else:
		set_process(false)


func _on_TabButton_toggled(button_pressed):
	selected = button_pressed
	emit_signal("TabButtonPressed", self)
	
	if button_pressed:
		tween.interpolate_property(leftBracket, 'rect_position', 
		leftBracket_end, leftBracket_start, .3, 
		Tween.TRANS_ELASTIC, Tween.EASE_OUT)
		tween.interpolate_property(rightBracket, 'rect_position', 
		rightBracket_end, rightBracket_start, .3, 
		Tween.TRANS_ELASTIC, Tween.EASE_OUT)
		tween.interpolate_property(self, 'modulate', 
		self.modulate, Color(1, 1, 1.1, 1.25), .3, 
		Tween.TRANS_ELASTIC, Tween.EASE_OUT)
		tween.start()
	else:
		tween.interpolate_property(leftBracket, 'rect_position', 
		leftBracket_start, leftBracket_end, .2, 
		Tween.TRANS_SINE, Tween.EASE_OUT)
		tween.interpolate_property(rightBracket, 'rect_position', 
		rightBracket_start, rightBracket_end, .2, 
		Tween.TRANS_SINE, Tween.EASE_OUT)
		tween.interpolate_property(self, 'modulate', 
		self.modulate, Color(1,1,1,1), .2, 
		Tween.TRANS_SINE, Tween.EASE_OUT)
		tween.start()


func set_pressed(pressed_):
	grab_focus()
	$TabButton.set_pressed(pressed_)
	_on_TabButton_toggled(pressed_)


func _on_TabButton_focus_entered():
	PopupLayer.last_focused = self
	emit_signal("TabButtonPressed", self)
	
	tween.interpolate_property(leftBracket, 'rect_position', 
	leftBracket.rect_position, leftBracket_start, .2, 
	Tween.TRANS_SINE, Tween.EASE_OUT)
	tween.interpolate_property(rightBracket, 'rect_position', 
	rightBracket.rect_position, rightBracket_start, .2, 
	Tween.TRANS_SINE, Tween.EASE_OUT)
	tween.interpolate_property(self, 'modulate', 
	self.modulate, Color(1, 1, 1.1, 1.2), .2, 
	Tween.TRANS_SINE, Tween.EASE_OUT)
	tween.start()


func _on_TabButton_focus_exited():
#	if get_focus_owner() != get_focus_neighbour(MARGIN_BOTTOM):
	tween.interpolate_property(leftBracket, 'rect_position', 
	leftBracket_start, leftBracket_end, .2, 
	Tween.TRANS_SINE, Tween.EASE_OUT)
	tween.interpolate_property(rightBracket, 'rect_position', 
	rightBracket_start, rightBracket_end, .2, 
	Tween.TRANS_SINE, Tween.EASE_OUT)
	tween.interpolate_property(self, 'modulate', 
	self.modulate, Color(1,1,1,1), .2, 
	Tween.TRANS_SINE, Tween.EASE_OUT)
	tween.start()
