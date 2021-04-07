extends Node2D





func _ready():
	Transitioner._in()


func _on_ShopEntrance_body_entered(_body):
# warning-ignore:return_value_discarded
	Transitioner._out(get_tree(), "res://Scenes/Buildings/DadsShop.tscn")
