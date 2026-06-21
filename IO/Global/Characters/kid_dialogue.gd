extends Node

var portrait = preload("res://Assets/Characters/IO-Kid_Default.png")

# ── Day 2 ─────────────────────────────────────────────────────────────────────
# The Kid appears after Student Day 2. They're restless, kicking the machine.
var day2 = [
	{
		"name": "Kid",
		"portrait": portrait,
		"text": "*A small kid walks up and stares at you.*",
		"type": "dialogue",
		"next_entry_index": 1
	},
	{
		"name": "Kid",
		"portrait": portrait,
		"text": "Mr. Machine... can I have a snack?",
		"type": "dialogue",
		"next_entry_index": 2
	},
	{
		"name": "You",
		"portrait": portrait,
		"text": "\"A kid? Out here alone?\"",
		"type": "dialogue",
		"next_entry_index": 3
	},
	{
		"name": "Kid",
		"portrait": portrait,
		"text": "My mom said I'm not supposed to talk to strangers... but you're not a person, right? You're just a machine.",
		"type": "option",
		"option_1_text": "That's right, just a machine.",
		"option_2_text": "I'm more than that.",
		"option_next_indices": [4, 5],
		"option_likeable_points": [0, 1]
	},
	{
		"name": "Kid",
		"portrait": portrait,
		"text": "Okay good! Then you won't mind if I take something?",
		"type": "dialogue",
		"next_entry_index": 6
	},
	{
		"name": "Kid",
		"portrait": portrait,
		"text": "Huh? More than a machine? That's weird. But cool!",
		"type": "dialogue",
		"next_entry_index": 6
	},
	{
		"name": "Kid",
		"portrait": portrait,
		"text": "I want something sweet! Give me the yummiest thing you have!",
		"type": "request",
		"request_items": ["Candy", "Juice Box", "Soda"],
		"bad_item": "Coffee",
		"request_success_entry_index": 7,
		"request_failure_entry_index": 9,
		"request_bad_option_entry_index": 10,
		"request_deny_entry_index": 12,
		"request_likeable_points_success": 2,
		"request_likeable_points_failure": -1,
		"request_likeable_points_bad": -3,
		"request_likeable_points_deny": -2
	},
	{
		"name": "Kid",
		"portrait": portrait,
		"text": "Yay! *He grabs it happily.* You're my favorite machine!",
		"type": "dialogue",
		"next_entry_index": 8
	},
	{
		"name": "Kid",
		"portrait": portrait,
		"text": "*He runs off with the snack.*",
		"type": "dialogue",
		"next_entry_index": 14
	},
	{
		"name": "Kid",
		"portrait": portrait,
		"text": "*He pouts.* This isn't what I wanted... but I guess it's okay.",
		"type": "dialogue",
		"next_entry_index": 14
	},
	{
		"name": "Kid",
		"portrait": portrait,
		"text": "Ew, coffee?! That's gross! *He pushes it back into the slot, jamming it.*",
		"type": "dialogue",
		"next_entry_index": 11
	},
	{
		"name": "Kid",
		"portrait": portrait,
		"text": "*He kicks the machine in frustration.*",
		"type": "dialogue",
		"next_entry_index": 14
	},
	{
		"name": "Kid",
		"portrait": portrait,
		"text": "*He looks at you with big eyes.* Please?",
		"type": "dialogue",
		"next_entry_index": 13
	},
	{
		"name": "Kid",
		"portrait": portrait,
		"text": "*He waits a moment, then slowly walks away.*",
		"type": "dialogue",
		"next_entry_index": 14
	},
	{
		"name": "You",
		"portrait": portrait,
		"text": "\"A kid wandering around... this place isn't what it used to be.\"",
		"type": "dialogue",
		"next_entry_index": 15
	},
	{
		"name": "You",
		"portrait": portrait,
		"text": "",
		"type": "end_of_day",
		"day_number": 2,
		"next_dialogue": 5
	}
]