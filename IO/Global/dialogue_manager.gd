extends Node

# ═══════════════════════════════════════════════════════════════════════════════
# DIALOGUE MANAGER — Data & Documentation
# ═══════════════════════════════════════════════════════════════════════════════
#
# Each dialogue is an Array of entry Dictionaries.
# The dialogue_box.gd reads these and renders them sequentially.
#
# ── Entry Types ───────────────────────────────────────────────────────────────
#
# 1. "dialogue" — Simple text display. Player clicks Next to proceed.
#    Fields:
#      name, portrait, text, type: "dialogue", next_entry_index: int
#
# 2. "option" — Two choices. Each choice can add/subtract Good_Points.
#    Fields:
#      name, portrait, text, type: "option"
#      option_1_text, option_2_text: String
#      option_next_indices: [int, int]  — where each option leads
#      option_likeable_points: [int, int]  — Good_Points delta per option
#        Example: option_likeable_points: [2, -1]
#          → Option 1 adds +2 Good_Points
#          → Option 2 subtracts 1 Good_Point
#
# 3. "request" — Player selects an item from the vending UI.
#    Fields:
#      name, portrait, text, type: "request"
#      request_items: [String]  — list of acceptable items
#      bad_item: String  — (optional) a specific wrong item with its own outcome
#      request_success_entry_index: int  — correct item given
#      request_failure_entry_index: int  — wrong item given
#      request_bad_option_entry_index: int  — bad_item given (if set)
#      request_deny_entry_index: int  — player clicked Deny
#      request_likeable_points_success: int  — Good_Points delta on correct item
#      request_likeable_points_failure: int  — Good_Points delta on wrong item
#      request_likeable_points_bad: int  — Good_Points delta on bad_item
#      request_likeable_points_deny: int  — Good_Points delta on deny
#        Defaults if omitted: success=+1, failure=-1, bad=-3, deny=-2
#
# 4. "branching" — Auto-resolves after typing finishes.
#    Checks Global.Good_Points against a threshold.
#    Fields:
#      name, portrait, text, type: "branching"
#      branch_min_points: int  — minimum Good_Points to pass
#      branch_success_entry_index: int  — goes here if Good_Points >= min
#      branch_failure_entry_index: int  — goes here if Good_Points < min
#
# 5. "leave_and_next_char" — Transition to next character's dialogue.
#    Fields:
#      name, portrait, text, type: "leave_and_next_char"
#      next_dialogue: int  — index into DIALOGUES array
#
# ── Good_Points System ────────────────────────────────────────────────────────
# Global.Good_Points tracks how "good" the vending machine has been.
# It accumulates across all interactions and affects:
#   - Branching dialogue paths
#   - Endings (Days 3-5)
#   - Character reactions
#
# ═══════════════════════════════════════════════════════════════════════════════

# ── Sample Dialogue Entry ─────────────────────────────────────────────────────
# This is a template showing ALL fields across all entry types.
# Copy this as a starting point when creating new entries.
var dialogue_sample = [
{
	"name": "Student",
	"portrait": preload("res://Assets/Characters/IO-Student_NonGlossed.png"),
	"text": "I want to apologize… but gently.",
	
	# type options: "dialogue", "option", "request", "branching", "leave_and_next_char"
	"type": "dialogue",

	# ── For "dialogue" type ──
	"next_entry_index": 1,               # which entry index to go to next

	# ── For "option" type ──
	"option_1_text": null,               # text for button 1
	"option_2_text": null,               # text for button 2
	"option_next_indices": null,         # [int, int] — entry indices for option 1 and 2
	"option_likeable_points": null,      # [int, int] — Good_Points delta per option e.g. [2, -1]

	# ── For "request" type ──
	"request_items": null,               # [String] — acceptable item names
	"bad_item": null,                    # String — specific wrong item with own outcome
	"request_success_entry_index": null, # correct item given
	"request_failure_entry_index": null, # wrong item given
	"request_bad_option_entry_index":null,# bad_item given (if set)
	"request_deny_entry_index": null,    # player clicked Deny
	"request_likeable_points_success": null,  # Good_Points delta on correct item (default +1)
	"request_likeable_points_failure": null,  # Good_Points delta on wrong item (default -1)
	"request_likeable_points_bad": null,      # Good_Points delta on bad_item (default -3)
	"request_likeable_points_deny": null,     # Good_Points delta on deny (default -2)

	# ── For "branching" type ──
	"branch_min_points": null,           # int — Good_Points threshold
	"branch_success_entry_index": null,  # goes here if Good_Points >= min
	"branch_failure_entry_index": null,  # goes here if Good_Points < min

	# ── For "leave_and_next_char" type ──
	"next_dialogue": null,               # int — index into DIALOGUES array
}
]

# ── Portrait References ───────────────────────────────────────────────────────
var student_portrait = preload("res://Assets/Characters/IO-Student_NonGlossed.png")
var worker_portrait = preload("res://Assets/Characters/IO-OfficeLady_NonGlossed_NoMakeup.png")
var karen_portrait = preload("res://Assets/Characters/IO-Karen.png")

# ── Day 1: Student ────────────────────────────────────────────────────────────
var student_day_1 = [
	{
		"name": "Student",
		"portrait": student_portrait,
		"text": "A new vending machine in town?",
		"type": "dialogue",
		"next_entry_index": 1
	},
	{
		"name": "Student",
		"portrait": student_portrait,
		"text": "Hey Mr. Vending Machine, I want something to eat before i head to class. Instant Noodles.",
		"type": "option",
		"option_1_text": "What a demanding student....",
		"option_2_text": "Hello!",
		"option_next_indices": [2, 3],
		"option_likeable_points": [-1, 2]  # rude response -1, friendly +2
	},
	{
		"name": "Student",
		"portrait": student_portrait,
		"text": "And who taught machines to talk back anyway? That's... kind of creepy.",
		"type": "dialogue",
		"next_entry_index": 4
	},
	{
		"name": "Student",
		"portrait": student_portrait,
		"text": ".... You're sentient..? That's... kind of cool, I guess.",
		"type": "dialogue",
		"next_entry_index": 4
	},
	{
		"name": "System",
		"portrait": student_portrait,
		"text": "On the right side, select an item that matches what the student is asking for. You can also select the 'Deny' option if you don't want to give them anything.",
		"type": "request",
		"request_items": ["Instant Noodles"],
		"request_success_entry_index": 5,
		"request_failure_entry_index": 6,
		"request_deny_entry_index": 7,
		"request_likeable_points_success": 3,   # gave exactly what they wanted
		"request_likeable_points_failure": -1,  # gave wrong thing
		"request_likeable_points_deny": -2      # denied entirely
	},
	{
		#success
		"name": "Student",
		"portrait": student_portrait,
		"text": "You're a good machine! This will fill me up for class.",
		"type": "dialogue",
		"next_entry_index": 8
	},
	{
		#failure
		"name": "Student",
		"portrait": student_portrait,
		"text": "This machine talks back... but it won't even give me what I want? That's disappointing.",
		"type": "dialogue",
		"next_entry_index": 8
	},
	{
		#denied
		"name": "Student",
		"portrait": student_portrait,
		"text": "Rubbish. No wonder i never saw anyone use this machine.",
		"type": "dialogue",
		"next_entry_index": 8
	},
	{
		#leave
		"name": "Student",
		"portrait": student_portrait,
		"text": "",
		"type": "leave_and_next_char",
		"next_dialogue": 1
	}
]

# ── Day 1: Office Worker ──────────────────────────────────────────────────────
var worker_day1 = [
	{
		"name": "Office Lady",
		"portrait": worker_portrait,
		"text": "Hello, I'm in a hurry here.... One Coffee Please",
		"type": "request",
		"request_items": ["Coffee"],
		"request_success_entry_index": 1,
		"request_failure_entry_index": 2,
		"request_deny_entry_index": 3,
		"request_likeable_points_success": 2,
		"request_likeable_points_failure": 0,  # she's in a rush, barely notices
		"request_likeable_points_deny": -1
	},
	{
		#success
		"name": "Office Lady",
		"portrait": worker_portrait,
		"text": "Oh! Thank you.",
		"type": "dialogue",
		"next_entry_index": 5
	},
	{
		#failure
		"name": "Office Lady",
		"portrait": worker_portrait,
		"text": "You got guts, No time to complain anyways, Thanks regardless",
		"type": "dialogue",
		"next_entry_index": 5
	},
	{
		#denied
		"name": "Office Lady",
		"portrait": worker_portrait,
		"text": "Oh well, That sucks, Thank you machine.",
		"type": "dialogue",
		"next_entry_index": 4
	},
	{
		#denied
		"name": "You",
		"portrait": worker_portrait,
		"text": "\"Thank You? But i....\"",
		"type": "dialogue",
		"next_entry_index": 5
	},
	{
		#thought
		"name": "You",
		"portrait": worker_portrait,
		"text": "\"Whatever i do... Looks like her response will be receptive...\"",
		"type": "dialogue",
		"next_entry_index": 6
	},
	{
		#thought
		"name": "You",
		"portrait": worker_portrait,
		"text": "\"Should i have tried another option?\"",
		"type": "dialogue",
		"next_entry_index": 7
	},
	{
		#exit transition
		"name": "You",
		"portrait": worker_portrait,
		"text": "\"Well, she's gone. Here comes another one...\"",
		"type": "dialogue",
		"next_entry_index": 8
	},
	{
		"name": "You",
		"portrait": worker_portrait,
		"text": "",
		"type": "leave_and_next_char",
		"next_dialogue": 2
	}
]

# ── Day 1: Karen ──────────────────────────────────────────────────────────────
var karen_day1 = [
	{
		"name": "Karen",
		"portrait": karen_portrait,
		"text": "EXCUSE ME? This machine is in my spot. MOVE.",
		"type": "dialogue",
		"next_entry_index": 1
	},
	{
		"name": "You",
		"portrait": karen_portrait,
		"text": "\"...I'm bolted to the ground.\"",
		"type": "dialogue",
		"next_entry_index": 2
	},
	{
		"name": "Karen",
		"portrait": karen_portrait,
		"text": "DON'T YOU SMART MOUTH ME, YOU.... BOXHEAD!.",
		"type": "dialogue",
		"next_entry_index": 3
	},
	{
		"name": "Karen",
		"portrait": karen_portrait,
		"text": "*She kicks the machine hard. A shudder runs through your frame.*",
		"type": "dialogue",
		"next_entry_index": 4
	},
	{
		"name": "You",
		"portrait": karen_portrait,
		"text": "\"..Boxhead?..Ah wait.. that... actually hurt.\"",
		"type": "dialogue",
		"next_entry_index": 5
	},
	{
		"name": "Karen",
		"portrait": karen_portrait,
		"text": "Good. Now give me something worth my time. And it better NOT be garbage.",
		"type": "dialogue",
		"next_entry_index": 6
	},
	{
		"name": "You",
		"portrait": karen_portrait,
		"text": "\"She didn't say what she wants... I have to guess.\"",
		"type": "dialogue",
		"next_entry_index": 7
	},
	{
		"name": "Karen",
		"portrait": karen_portrait,
		"text": "Well? I don't have all day. Pick something USEFUL.",
		"type": "request",
		"request_items": ["Coffee", "Energy Drink"], 
		"bad_item": "Instant Noodles",  
		"request_success_entry_index": 8,
		"request_failure_entry_index": 10,
		"request_bad_option_entry_index": 12,
		"request_deny_entry_index": 14,
		"request_likeable_points_success": 1,   # she's grudgingly satisfied
		"request_likeable_points_failure": -2,  # she's annoyed
		"request_likeable_points_bad": -4,      # she's FURIOUS (noodles = insult)
		"request_likeable_points_deny": -3      # she's enraged
	},
	{
		# success — gave Coffee or Energy Drink
		"name": "Karen",
		"portrait": karen_portrait,
		"text": "Hmph. Finally, something that isn't completely useless.",
		"type": "dialogue",
		"next_entry_index": 9
	},
	{
		"name": "Karen",
		"portrait": karen_portrait,
		"text": "*She snatches it and walks off without another word.*",
		"type": "dialogue",
		"next_entry_index": 16
	},
	{
		"name": "Karen",
		"portrait": karen_portrait,
		"text": "Are you KIDDING me? I'm not a CHILD. What am I supposed to do with THIS?",
		"type": "dialogue",
		"next_entry_index": 11
	},
	{
		"name": "Karen",
		"portrait": karen_portrait,
		"text": "*She slams the item back into the dispensing slot, jamming it.*",
		"type": "dialogue",
		"next_entry_index": 16
	},
	{
		# bad_item — gave Instant Noodles
		"name": "Karen",
		"portrait": karen_portrait,
		"text": "NOODLES?! You think I'm some kind of BROKE COLLEGE STUDENT?!",
		"type": "dialogue",
		"next_entry_index": 13
	},
	{
		"name": "Karen",
		"portrait": karen_portrait,
		"text": "*She kicks you again — harder this time. Something inside rattles loose.*",
		"type": "dialogue",
		"next_entry_index": 16
	},
	{
		# deny
		"name": "Karen",
		"portrait": karen_portrait,
		"text": "You're REFUSING me?! I'll have you SCRAPPED. I know the manager!",
		"type": "dialogue",
		"next_entry_index": 15
	},
	{
		"name": "Karen",
		"portrait": karen_portrait,
		"text": "*She storms off, muttering about calling someone. You feel a chill.*",
		"type": "dialogue",
		"next_entry_index": 16
	},
	{
		# exit transition
		"name": "You",
		"portrait": karen_portrait,
		"text": "\"...What just happened?\"",
		"type": "dialogue",
		"next_entry_index": 17
	},
	{
		"name": "You",
		"portrait": karen_portrait,
		"text": "\"I think she broke something inside me...\"",
		"type": "dialogue",
		"next_entry_index": 18
	},
	{
		"name": "You",
		"portrait": karen_portrait,
		"text": "",
		"type": "leave_and_next_char",
		"next_dialogue": 2  # goes to next character after Karen
	}
]

# ── Master Dialogue List ──────────────────────────────────────────────────────
# Index 0: Student (Day 1)
# Index 1: Office Worker (Day 1)
# Index 2: Karen (Day 1)
# Index 3+: Future characters / days
var DIALOGUES = [student_day_1, worker_day1, karen_day1]

func _ready():
	await get_tree().process_frame
	get_tree().get_first_node_in_group("dialog_box").start(student_day_1)
