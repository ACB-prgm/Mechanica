extends CanvasLayer


onready var tween = $Tween
onready var colorRect = $ColorRect

var tree
var scene


func _ready():
	colorRect.modulate = Color(1,1,1,0)


func _in():
	
	tween.interpolate_property(colorRect, "modulate", 
	Color(1,1,1,1), Color(1,1,1,0), 
	.7, Tween.TRANS_SINE, Tween.EASE_IN)
	
	tween.start()


func _out(new_tree, new_scene):
	tree = new_tree
	scene = new_scene
	
	tween.interpolate_property(colorRect, "modulate", 
	colorRect.modulate, Color(1,1,1,1), 
	.5, Tween.TRANS_SINE, Tween.EASE_OUT)
	
	tween.start()


func _on_Tween_tween_all_completed():
	if colorRect.modulate == Color(1,1,1,1):
		tree.change_scene(scene)
