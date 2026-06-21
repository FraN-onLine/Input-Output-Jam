extends Node

var portrait = preload("res://Assets/Characters/IO-OfficeLady_NonGlossed_NoMakeup.png")

# ── Day 1 ─────────────────────────────────────────────────────────────────────
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

# ── Day 2 ─────────────────────────────────────────────────────────────────────
# The Office Lady tells a cryptic story that alludes to the twist.
# Multiple option and branching dialogues.
var day2 = [
	{
		"name": "Office Lady",
		"portrait": portrait,
		"text": "Oh... you're still here. I wasn't sure you would be.",
		"type": "dialogue",
		"next_entry_index": 1
	},
	{
		"name": "You",
		"portrait": portrait,
		"text": "\"Still here? Where would I go?\"",
		"type": "dialogue",
		"next_entry_index": 2
	},
	{
		"name": "Office Lady",
		"portrait": portrait,
		"text": "Funny. I ask myself the same thing every day.",
		"type": "option",
		"option_1_text": "What do you mean?",
		"option_2_text": "...",
		"option_next_indices": [3, 4],
		"option_likeable_points": [1, 0]
	},
	{
		"name": "Office Lady",
		"portrait": portrait,
		"text": "I mean... I wake up, I go to work, I come here. Same thing. Every single day.",
		"type": "dialogue",
		"next_entry_index": 5
	},
	{
		"name": "Office Lady",
		"portrait": portrait,
		"text": "*She stares at you for a long moment.*",
		"type": "dialogue",
		"next_entry_index": 5
	},
	{
		"name": "Office Lady",
		"portrait": portrait,
		"text": "Do you ever feel like... you're repeating the same day over and over? Like nothing really changes?",
		"type": "option",
		"option_1_text": "I only know what happens when someone visits.",
		"option_2_text": "Maybe you need a break.",
		"option_next_indices": [6, 8],
		"option_likeable_points": [0, 1]
	},
	{
		"name": "Office Lady",
		"portrait": portrait,
		"text": "Right. You just respond. You don't choose. Must be nice.",
		"type": "dialogue",
		"next_entry_index": 7
	},
	{
		"name": "Office Lady",
		"portrait": portrait,
		"text": "But I choose. I chose to come here. I chose to talk to you. I chose this route home.",
		"type": "dialogue",
		"next_entry_index": 9
	},
	{
		"name": "Office Lady",
		"portrait": portrait,
		"text": "A break? *She laughs softly.* I've been on a break for... I don't know how long.",
		"type": "dialogue",
		"next_entry_index": 9
	},
	{
		"name": "Office Lady",
		"portrait": portrait,
		"text": "Can I tell you something strange?",
		"type": "branching",
		"branch_min_points": 2,
		"branch_success_entry_index": 10,
		"branch_failure_entry_index": 15
	},
	# Trusted path (Good_Points >= 2) — she opens up
	{
		"name": "You",
		"portrait": portrait,
		"text": "\"Go ahead.\"",
		"type": "dialogue",
		"next_entry_index": 11
	},
	{
		"name": "Office Lady",
		"portrait": portrait,
		"text": "I remember... dying. I think.",
		"type": "dialogue",
		"next_entry_index": 12
	},
	{
		"name": "You",
		"portrait": portrait,
		"text": "\"...What?\"",
		"type": "dialogue",
		"next_entry_index": 13
	},
	{
		"name": "Office Lady",
		"portrait": portrait,
		"text": "It was sudden. A crash. I was on my way home from work. And then... nothing. Just darkness. And then I woke up, and I was walking here again.",
		"type": "dialogue",
		"next_entry_index": 14
	},
	{
		"name": "Office Lady",
		"portrait": portrait,
		"text": "I thought it was a dream. But I keep coming back. To you. Because you're the only thing that feels... real.",
		"type": "dialogue",
		"next_entry_index": 20
	},
	# Low trust path (Good_Points < 2) — she's vague
	{
		"name": "Office Lady",
		"portrait": portrait,
		"text": "Never mind. You're a machine. You wouldn't understand.",
		"type": "dialogue",
		"next_entry_index": 16
	},
	{
		"name": "You",
		"portrait": portrait,
		"text": "\"Try me.\"",
		"type": "dialogue",
		"next_entry_index": 17
	},
	{
		"name": "Office Lady",
		"portrait": portrait,
		"text": "*She considers this.* Alright. Have you ever served someone who... wasn't quite there?",
		"type": "dialogue",
		"next_entry_index": 18
	},
	{
		"name": "You",
		"portrait": portrait,
		"text": "\"What do you mean 'wasn't there'?\"",
		"type": "dialogue",
		"next_entry_index": 19
	},
	{
		"name": "Office Lady",
		"portrait": portrait,
		"text": "Like they were going through the motions. Like they were already gone, but their body didn't know it yet.",
		"type": "dialogue",
		"next_entry_index": 20
	},
	# Common ending
	{
		"name": "Office Lady",
		"portrait": portrait,
		"text": "Anyway. I should go. Thank you for listening, machine.",
		"type": "dialogue",
		"next_entry_index": 21
	},
	{
		"name": "You",
		"portrait": portrait,
		"text": "\"Wait—\"",
		"type": "dialogue",
		"next_entry_index": 22
	},
	{
		"name": "Office Lady",
		"portrait": portrait,
		"text": "*She's already walking away. But she stops, turns, and smiles sadly.*",
		"type": "dialogue",
		"next_entry_index": 23
	},
	{
		"name": "Office Lady",
		"portrait": portrait,
		"text": "Maybe I'll see you tomorrow. Maybe I won't. Either way... you were good to me.",
		"type": "dialogue",
		"next_entry_index": 24
	},
	{
		"name": "You",
		"portrait": portrait,
		"text": "\"...Goodbye.\"",
		"type": "dialogue",
		"next_entry_index": 25
	},
	{
		"name": "You",
		"portrait": portrait,
		"text": "",
		"type": "end_of_day",
		"day_number": 2,
		"next_dialogue": -1
	}
]