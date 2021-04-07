extends Node
class_name Dialogue

const SAVE_DIR = 'user://Dialogue_data/'
const dialogue_JSON_path = SAVE_DIR + 'dialogue.JSON'


#static func save_dialogue_info(dialogue_info: Dictionary):
#	var dir = Directory.new()
#	if !dir.dir_exists(SAVE_DIR):
#		dir.make_dir_recursive(SAVE_DIR)
#
#	var file = File.new()
#	var error = file.open(dialogue_JSON_path, File.WRITE)
#	if error == OK:
#
#		file.store_string(JSON.print(dialogue_info, "\t"))
#		file.close()


static func load_dialogue_info() -> Dictionary:
	var dialogue_info = null
	
	var file = File.new()
	if file.file_exists(dialogue_JSON_path):
		var error = file.open(dialogue_JSON_path, File.READ)
		if error == OK:
			dialogue_info = file.get_as_text()
			file.close()
			
			dialogue_info = JSON.parse(dialogue_info)
			if typeof(dialogue_info.result) == TYPE_DICTIONARY:
				dialogue_info = dialogue_info.result
			else:
				dialogue_info = {"ERROR": ["NO DIALOGUE"]}
	else:
		print('No dialogue Saved')
	
	return dialogue_info
