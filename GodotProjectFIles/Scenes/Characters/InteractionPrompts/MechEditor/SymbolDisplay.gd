extends Control


const BULWARK_DESCRIPTION = "Defensive specialists built to protect and endure."
const DREADNAUT_DESCRIPTION = "Powerful assault machines built for destruction."
const GUNDAM_DESCRIPTION = "Well-balanced warriors equipt for any situation."
const TYNKER_DESCRIPTION = "Support mechs that enhance their allies and debilitate their enemies."

onready var titleLabel = $TitleLabel
onready var displayTextureRect = $TextureRect
onready var descriptionLabel = $DescriptionLabel
onready var buffsContainer = $BuffsHBoxContainer

var BULWARK_SYMBOL = preload("res://Images/Popups/MechEditor/AIFocus/AIFocus_Symbol_Bulwark.png")
var DREADNAUT_SYMBOL = preload("res://Images/Popups/MechEditor/AIFocus/AIFocus_Symbol_Dreadnaut.png")
var GUNDAM_SYMBOL = preload("res://Images/Popups/MechEditor/AIFocus/AIFocus_Symbol_Gundam.png")
var TYNKER_SYMBOL = preload("res://Images/Popups/MechEditor/AIFocus/AIFocus_Symbol_Tynker.png")
var buffTSCN = preload("res://Scenes/Characters/InteractionPrompts/MechEditor/StatBuff.tscn")

var current_texture = GUNDAM_SYMBOL
var current_description = GUNDAM_DESCRIPTION


func _ready():
	titleLabel.modulate = Color(1, 1, 1.1, 1.1)
	displayTextureRect.modulate = Color(1, 1, 1.2, 1.1)


func _on_OptionsDisplay_item_selected(item):
	clear_buffs_container()
	
	match item:
		"bulwark":
			current_texture = BULWARK_SYMBOL
			current_description = BULWARK_DESCRIPTION
		"dreadnaut":
			current_texture = DREADNAUT_SYMBOL
			current_description = DREADNAUT_DESCRIPTION
		"gundam":
			current_texture = GUNDAM_SYMBOL
			current_description = GUNDAM_DESCRIPTION
		"tynker":
			current_texture = TYNKER_SYMBOL
			current_description = TYNKER_DESCRIPTION
	
	titleLabel.set_text(item)
	displayTextureRect.set_texture(current_texture)
	descriptionLabel.set_text(current_description)
	
	var info = MechInfo.AI_focus_info.get(item)
	var stat_buffs = info.get("stat_buffs")
	for stat in stat_buffs.keys():
		create_statbuff(stat_buffs.get(stat), stat)


func create_statbuff(buff:float, stat:String):
	var statbuffINS = buffTSCN.instance()
	statbuffINS.display(buff, stat)
	buffsContainer.add_child(statbuffINS)


func clear_buffs_container():
	for child in buffsContainer.get_children():
		child.queue_free()
