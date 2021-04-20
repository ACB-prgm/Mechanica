extends StaticBody2D


onready var shop_toplayer = $Shop/Inside_TopLayer
onready var shop_doorpost = $Shop/DoorPost
onready var shop = $Shop
onready var room_exterior = $Room/Exterior
onready var room_toplayer = $Room/Inside_TopLayer
onready var tween = $Tween
onready var ysort = get_parent().get_node("YSort")


func _on_RoomDoorway_doorway_used(direction):
	match direction:
		1: # into shop
			shop_doorpost.z_index = 0
		2: # into room
			for child in ysort.get_children():
				if child != Globals.player:
					tween.interpolate_property(child, "modulate", child.modulate, 
					Color(1,1,1,0), .25, Tween.TRANS_SINE, Tween.EASE_IN)
			
			tween.interpolate_property(shop, "modulate", shop.modulate, 
			Color(1,1,1,0), .25, Tween.TRANS_SINE, Tween.EASE_IN)
			tween.interpolate_property(room_exterior, "modulate", room_exterior.modulate, 
			Color(1,1,1,0), .3, Tween.TRANS_SINE, Tween.EASE_IN)
			
			tween.start()


func _on_RoomDoorway_one_entered(two_entered):
	if two_entered:
		room_toplayer.z_index = 0
		
		for child in ysort.get_children():
				if child != Globals.player:
					tween.interpolate_property(child, "modulate", child.modulate, 
					Color(1,1,1,1), .25, Tween.TRANS_SINE, Tween.EASE_IN)
		
		tween.interpolate_property(room_exterior, "modulate", room_exterior.modulate, 
		Color(1,1,1,1), .3, Tween.TRANS_SINE, Tween.EASE_IN)
		tween.interpolate_property(shop, "modulate", shop.modulate, 
		Color(1,1,1,1), .25, Tween.TRANS_SINE, Tween.EASE_IN)
		tween.start()
	
	else:
		shop_doorpost.z_index = 1


func _on_RoomDoorway_two_entered(one_entered):
	if !one_entered:
		room_toplayer.z_index = 1

