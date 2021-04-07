extends Node2D




func _on_ShopEntrance_body_entered(_body):
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/Buildings/DadsShop.tscn")
