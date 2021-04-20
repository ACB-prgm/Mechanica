extends Node2D


const level = "Dad's Shop"

var mainChar_TSCN = preload("res://Scenes/Characters/Main/MainChar.tscn")

onready var shop = $DadsShop


func _ready():
	var player_ins = mainChar_TSCN.instance()
	
	var spawn_pos
	match Globals.levels_info.get(level).get("position"):
		1:
			spawn_pos = $DadsShop/Room/Position2D.global_position
			shop._on_RoomDoorway_doorway_used(2)
		2:
			spawn_pos = $DadsShop/Shop/Position2D.global_position
	
	player_ins.global_position = spawn_pos
	$YSort.add_child(player_ins)
	
	
	Transitioner._in()


func _on_Area2D_body_entered(_body):
	Globals.levels_info[level]["position"] = 2
# warning-ignore:return_value_discarded
	Transitioner._out(get_tree(), "res://Scenes/Testing/World.tscn")
