extends Node

var portrait = preload("res://Assets/Characters/IO-OfficeLady_NonGlossed_NoMakeup.png")

var day1 = [
	{
		"name": "Office Lady",
		"portrait": portrait,
		"text": "Hello, I'm in a hurry here.... One Coffee Please",
		"type": "request",
		"request_items": ["Coffee"],
		"request_success_entry_index": 1,
		"request_failure_entry_index": 2,
		"request_deny_entry_index": 3,
		"request_likeable_points_success": 2,
		"request_likeable_points_failure": 0,
		"request_likeable_points_deny": -1
	},
	{
		"name": "Office Lady",
		"portrait": portrait,
		"text": "Oh! Thank you.",
		"type": "dialogue",
		"next_entry_index": 5
	},
	{
		"name": "Office Lady",
		"portrait": portrait,
		"text": "You got guts, No time to complain anyways, Thanks regardless",
		"type": "dialogue",
		"next_entry_index": 5
	},
	{
		"name": "Office Lady",
		"portrait": portrait,
		"text": "Oh well, That sucks, Thank you machine.",
		"type": "dialogue",
		"next_entry_index": 4
	},
	{
		"name": "You",
		"portrait": portrait,
		"text": "\"Thank You? But i....\"",
		"type": "dialogue",
		"next_entry_index": 5
	},
	{
		"name": "You",
		"portrait": portrait,
		"text": "\"Whatever i do... Looks like her response will be receptive...\"",
		"type": "dialogue",
		"next_entry_index": 6
	},
	{
		"name": "You",
		"portrait": portrait,
		"text": "\"Should i have tried another option?\"",
		"type": "dialogue",
		"next_entry_index": 7
	},
	{
		"name": "You",
		"portrait": portrait,
		"text": "\"Well, she's gone. Here comes another one...\"",
		"type": "dialogue",
		"next_entry_index": 8
	},
	{
		"name": "You",
		"portrait": portrait,
		"text": "",
		"type": "leave_and_next_char",
		"next_dialogue": 2
	}
]