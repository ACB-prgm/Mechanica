extends Node2D


func _on_Area2D_body_entered(_body):
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/Testing/World.tscn")
