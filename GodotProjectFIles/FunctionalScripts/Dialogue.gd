extends Node


var dict: Dictionary = {
	"Father_001": [
		"Well, good morning sunshine!",
		"Nice of you to join me!",
		"That mech over there needs to have it's AI's focus reset.",
		"Head over to the computer and give it a shot would ya?",
		["CHANGE_DIALOGUE", "Father_002"]
	],
	"Father_002": [
		"That mech over there needs to have it's AI's focus reset.",
		"Head over to the computer and give it a shot would ya?"
	],
	"Father_003": [
		"Hey!",
		"You're not gunna leave your old man with all the work here are ya?",
		["CHANGE_DIALOGUE", "Father_002"]
	]
}
