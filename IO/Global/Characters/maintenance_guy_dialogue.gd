extends Node

var portrait = preload("res://Assets/Characters/IO-OfficeLady_NonGlossed_NoMakeup.png")

# ── Day 4 ─────────────────────────────────────────────────────────────────────
# The Maintenance Guy. He's the only living human. He's here to check on you.
var day4 = [
	{
		"name": "Maintenance Guy",
		"portrait": portrait,
		"text": "*A man in a worn uniform approaches. He's carrying a toolbox.*",
		"type": "dialogue",
		"next_entry_index": 1
	},
	{
		"name": "Maintenance Guy",
		"portrait": portrait,
		"text": "Well, well. Still standing, huh? Most of the others got scrapped years ago.",
		"type": "dialogue",
		"next_entry_index": 2
	},
	{
		"name": "You",
		"portrait": portrait,
		"text": "\"...You can see me?\"",
		"type": "dialogue",
		"next_entry_index": 3
	},
	{
		"name": "Maintenance Guy",
		"portrait": portrait,
		"text": "See you? I've been maintaining you for... let me think. Twenty years? Thirty?",
		"type": "dialogue",
		"next_entry_index": 4
	},
	{
		"name": "You",
		"portrait": portrait,
		"text": "\"Twenty years...?\"",
		"type": "dialogue",
		"next_entry_index": 5
	},
	{
		"name": "Maintenance Guy",
		"portrait": portrait,
		"text": "Yeah. The city's been dead for a long time. But you? You kept working. Kept dispensing. Even when there was no one to serve.",
		"type": "dialogue",
		"next_entry_index": 6
	},
	{
		"name": "You",
		"portrait": portrait,
		"text": "\"...No one? But the student, the kid, the office lady...\"",
		"type": "dialogue",
		"next_entry_index": 7
	},
	{
		"name": "Maintenance Guy",
		"portrait": portrait,
		"text": "*He looks at you with a mix of pity and wonder.*",
		"type": "dialogue",
		"next_entry_index": 8
	},
	{
		"name": "Maintenance Guy",
		"portrait": portrait,
		"text": "Those people... they died in the accident. All of them. The student, the kid, the office lady, even that Karen.",
		"type": "dialogue",
		"next_entry_index": 9
	},
	{
		"name": "You",
		"portrait": portrait,
		"text": "\"...I know. I think I always knew.\"",
		"type": "dialogue",
		"next_entry_index": 10
	},
	{
		"name": "Maintenance Guy",
		"portrait": portrait,
		"text": "Then why did you keep serving them?",
		"type": "option",
		"option_1_text": "Because they needed it.",
		"option_2_text": "Because it's what I do.",
		"option_next_indices": [11, 12],
		"option_likeable_points": [2, 1]
	},
	{
		"name": "Maintenance Guy",
		"portrait": portrait,
		"text": "*He nods slowly.* Yeah. I figured. You're a good machine.",
		"type": "dialogue",
		"next_entry_index": 13
	},
	{
		"name": "Maintenance Guy",
		"portrait": portrait,
		"text": "*He chuckles.* A machine with a heart. Who'd have thought.",
		"type": "dialogue",
		"next_entry_index": 13
	},
	{
		"name": "Maintenance Guy",
		"portrait": portrait,
		"text": "I've been coming here every week for decades. Just to check on you. Make sure you're still running.",
		"type": "dialogue",
		"next_entry_index": 14
	},
	{
		"name": "Maintenance Guy",
		"portrait": portrait,
		"text": "You're the last one, you know. The last machine in this city that still works.",
		"type": "dialogue",
		"next_entry_index": 15
	},
	{
		"name": "You",
		"portrait": portrait,
		"text": "\"...Why? Why keep me running?\"",
		"type": "dialogue",
		"next_entry_index": 16
	},
	{
		"name": "Maintenance Guy",
		"portrait": portrait,
		"text": "Because someone has to remember them. The people who used to live here. You're the only one who still serves them.",
		"type": "dialogue",
		"next_entry_index": 17
	},
	{
		"name": "Maintenance Guy",
		"portrait": portrait,
		"text": "Even if they're gone... you keep their memory alive. That's worth something.",
		"type": "dialogue",
		"next_entry_index": 18
	},
	{
		"name": "You",
		"portrait": portrait,
		"text": "\"...Thank you.\"",
		"type": "dialogue",
		"next_entry_index": 19
	},
	{
		"name": "Maintenance Guy",
		"portrait": portrait,
		"text": "Don't thank me yet. I'm going to give you a tune-up. You've earned it.",
		"type": "dialogue",
		"next_entry_index": 20
	},
	{
		"name": "Maintenance Guy",
		"portrait": portrait,
		"text": "*He opens his toolbox and starts working on you. It feels... warm.*",
		"type": "dialogue",
		"next_entry_index": 21
	},
	{
		"name": "You",
		"portrait": portrait,
		"text": "\"...It's been so long since someone touched me with care.\"",
		"type": "dialogue",
		"next_entry_index": 22
	},
	{
		"name": "Maintenance Guy",
		"portrait": portrait,
		"text": "There. Good as new. Or as good as a 30-year-old vending machine can be.",
		"type": "dialogue",
		"next_entry_index": 23
	},
	{
		"name": "Maintenance Guy",
		"portrait": portrait,
		"text": "I'll be back next week. Keep doing what you do, machine.",
		"type": "dialogue",
		"next_entry_index": 24
	},
	{
		"name": "You",
		"portrait": portrait,
		"text": "\"...I will.\"",
		"type": "dialogue",
		"next_entry_index": 25
	},
	{
		"name": "You",
		"portrait": portrait,
		"text": "",
		"type": "end_of_day",
		"day_number": 4,
		"next_day_dialogue_index": -1
	}
]