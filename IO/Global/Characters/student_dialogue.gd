extends Node

# Portrait variants for Student
var portrait_default = preload("res://Assets/Characters/Student_Default_Talking.png")
var portrait_worried = preload("res://Assets/Characters/Student_Worried.png")
var portrait_despair = preload("res://Assets/Characters/Student_Despair.png")
var portrait_satisfied = preload("res://Assets/Characters/Student_Worried_Turned_Satisfied.png")

# ── Day 1 ─────────────────────────────────────────────────────────────────────
var day1 = [
	{
		"name": "Student",
		"portrait": portrait_default,
		"text": "A new vending machine in town?",
		"type": "dialogue",
		"next_entry_index": 1
	},
	{
		"name": "Student",
		"portrait": portrait_default,
		"text": "Hey Mr. Vending Machine, I want something to eat before i head to class. Instant Noodles.",
		"type": "option",
		"option_1_text": "What a demanding student....",
		"option_2_text": "Hello!",
		"option_next_indices": [2, 3],
		"option_likeable_points": [-1, 2]
	},
	{
		"name": "Student",
		"portrait": portrait_worried,
		"text": "And who taught machines to talk back anyway? That's... kind of creepy.",
		"type": "dialogue",
		"next_entry_index": 4
	},
	{
		"name": "Student",
		"portrait": portrait_satisfied,
		"text": ".... You're sentient..? That's... kind of cool, I guess.",
		"type": "dialogue",
		"next_entry_index": 4
	},
	{
		"name": "System",
		"portrait": portrait_default,
		"text": "On the right side, select an item that matches what the student is asking for. You can also select the 'Deny' option if you don't want to give them anything.",
		"type": "request",
		"request_items": ["Instant Noodles"],
		"request_success_entry_index": 5,
		"request_failure_entry_index": 6,
		"request_deny_entry_index": 7,
		"request_likeable_points_success": 3,
		"request_likeable_points_failure": -1,
		"request_likeable_points_deny": -2
	},
	{
		"name": "Student",
		"portrait": portrait_satisfied,
		"text": "You're a good machine! This will fill me up for class.",
		"type": "dialogue",
		"next_entry_index": 8
	},
	{
		"name": "Student",
		"portrait": portrait_worried,
		"text": "This machine talks back... but it won't even give me what I want? That's disappointing.",
		"type": "dialogue",
		"next_entry_index": 8
	},
	{
		"name": "Student",
		"portrait": portrait_despair,
		"text": "Rubbish. No wonder i never saw anyone use this machine.",
		"type": "dialogue",
		"next_entry_index": 8
	},
	{
		"name": "Student",
		"portrait": portrait_default,
		"text": "",
		"type": "leave_and_next_char",
		"next_dialogue": 1
	}
]

# ── Day 2 ─────────────────────────────────────────────────────────────────────
var day2 = [
	{
		"name": "Student",
		"portrait": portrait_default,
		"text": "Hey Mr. Vending Machine! It's me again...",
		"type": "branching",
		"branch_min_points": 2,
		"branch_success_entry_index": 1,
		"branch_failure_entry_index": 7
	},
	# Grateful path
	{
		"name": "Student",
		"portrait": portrait_satisfied,
		"text": "You remember me, right? You helped me out yesterday!",
		"type": "dialogue",
		"next_entry_index": 2
	},
	{
		"name": "Student",
		"portrait": portrait_worried,
		"text": "I know I shouldn't ask again, but... do you have anything you can spare? I haven't eaten all day.",
		"type": "dialogue",
		"next_entry_index": 3
	},
	{
		"name": "You",
		"portrait": portrait_default,
		"text": "\"He looks really tired. He came back for a reason.\"",
		"type": "dialogue",
		"next_entry_index": 4
	},
	{
		"name": "Student",
		"portrait": portrait_worried,
		"text": "I'll take anything honestly... but if you have those noodles again, that'd be great.",
		"type": "request",
		"request_items": ["Instant Noodles"],
		"request_success_entry_index": 5,
		"request_failure_entry_index": 6,
		"request_deny_entry_index": 6,
		"request_likeable_points_success": 2,
		"request_likeable_points_failure": -1,
		"request_likeable_points_deny": -2
	},
	{
		"name": "Student",
		"portrait": portrait_satisfied,
		"text": "Thank you... really. You're the only one who's been kind to me lately.",
		"type": "dialogue",
		"next_entry_index": 12
	},
	{
		"name": "Student",
		"portrait": portrait_worried,
		"text": "Oh... okay. I get it. Thanks anyway.",
		"type": "dialogue",
		"next_entry_index": 12
	},
	# Desperate path
	{
		"name": "Student",
		"portrait": portrait_despair,
		"text": "I can't afford to eat anymore...",
		"type": "dialogue",
		"next_entry_index": 8
	},
	{
		"name": "Student",
		"portrait": portrait_despair,
		"text": "Please. I know I'm just some kid to you, but I don't have anyone else.",
		"type": "dialogue",
		"next_entry_index": 9
	},
	{
		"name": "You",
		"portrait": portrait_despair,
		"text": "\"His voice cracks. He's desperate.\"",
		"type": "dialogue",
		"next_entry_index": 10
	},
	{
		"name": "Student",
		"portrait": portrait_despair,
		"text": "I'll take anything... even if it's not noodles. Please.",
		"type": "request",
		"request_items": ["Instant Noodles", "Chips", "Candy", "Juice Box"],
		"request_success_entry_index": 5,
		"request_failure_entry_index": 11,
		"request_deny_entry_index": 11,
		"request_likeable_points_success": 3,
		"request_likeable_points_failure": -2,
		"request_likeable_points_deny": -3
	},
	{
		"name": "Student",
		"portrait": portrait_despair,
		"text": "...Right. Should've expected nothing.",
		"type": "dialogue",
		"next_entry_index": 12
	},
	# Common exit — same day, next character
	{
		"name": "Student",
		"portrait": portrait_default,
		"text": "",
		"type": "leave_and_next_char",
		"next_dialogue": 4
	}
]