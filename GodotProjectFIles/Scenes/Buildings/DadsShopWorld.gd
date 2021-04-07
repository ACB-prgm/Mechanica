extends Node2D




func _ready():
	Transitioner._in()


func _on_Area2D_body_entered(_body):
# warning-ignore:return_value_discarded
	Transitioner._out(get_tree(), "res://Scenes/Testing/World.tscn")
