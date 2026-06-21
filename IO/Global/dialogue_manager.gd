extends Node

# ═══════════════════════════════════════════════════════════════════════════════
# DIALOGUE MANAGER — Hub & Documentation
# ═══════════════════════════════════════════════════════════════════════════════
#
# Each dialogue is an Array of entry Dictionaries.
# The dialogue_box.gd reads these and renders them sequentially.
#
# ── Entry Types ───────────────────────────────────────────────────────────────
#
# 1. "dialogue" — Simple text display. Player clicks Next to proceed.
# 2. "option" — Two choices with option_likeable_points for Good_Points deltas.
# 3. "request" — Player selects an item from the vending UI.
# 4. "branching" — Auto-resolves via Good_Points threshold after Next click.
# 5. "leave_and_next_char" — Portrait slide + fade to next character
# 6. "end_of_day" — Full-screen fade to black, day text, next day
#
# ═══════════════════════════════════════════════════════════════════════════════

# ── Sample Dialogue Entry ─────────────────────────────────────────────────────
var dialogue_sample = [
{
	"name": "Student",
	"portrait": preload("res://Assets/Characters/IO-Student_NonGlossed.png"),
	"text": "I want to apologize… but gently.",
	"type": "dialogue",
	"next_entry_index": 1,
	"option_1_text": null,
	"option_2_text": null,
	"option_next_indices": null,
	"option_likeable_points": null,
	"request_items": null,
	"bad_item": null,
	"request_success_entry_index": null,
	"request_failure_entry_index": null,
	"request_bad_option_entry_index": null,
	"request_deny_entry_index": null,
	"request_likeable_points_success": null,
	"request_likeable_points_failure": null,
	"request_likeable_points_bad": null,
	"request_likeable_points_deny": null,
	"branch_min_points": null,
	"branch_success_entry_index": null,
	"branch_failure_entry_index": null,
	"next_dialogue": null,
}
]

# ── Import Character Dialogues ────────────────────────────────────────────────
var StudentDialogue = preload("res://Global/Characters/student_dialogue.gd")
var WorkerDialogue = preload("res://Global/Characters/worker_dialogue.gd")
var KarenDialogue = preload("res://Global/Characters/karen_dialogue.gd")
var KidDialogue = preload("res://Global/Characters/kid_dialogue.gd")

# ── Master Dialogue List ──────────────────────────────────────────────────────
# Index 0: Student Day 1
# Index 1: Worker Day 1
# Index 2: Karen Day 1  (end_of_day → 3)
# Index 3: Student Day 2 (end_of_day → 4)
# Index 4: Kid Day 2     (end_of_day → 5)
# Index 5: Karen Day 2   (leave → 6)
# Index 6: Worker Day 2  (end_of_day → -1 = game ends)
var DIALOGUES = []

func _ready():
	var s = StudentDialogue.new()
	var w = WorkerDialogue.new()
	var k = KarenDialogue.new()
	var kid = KidDialogue.new()
	
	DIALOGUES = [
		s.day1,   # 0
		w.day1,   # 1
		k.day1,   # 2
		s.day2,   # 3
		kid.day2, # 4
		k.day2,   # 5
		w.day2    # 6
	]
	
	await get_tree().process_frame
	get_tree().get_first_node_in_group("dialog_box").start(DIALOGUES[0])