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
var MaintenanceDialogue = preload("res://Global/Characters/maintenance_guy_dialogue.gd")

# ── Master Dialogue List ──────────────────────────────────────────────────────
# Day 1 (fixed order):
#   0: Student Day 1
#   1: Worker Day 1
#   2: Karen Day 1  (end_of_day → 3)
# Day 2 (shuffled):
#   3-6: Student/Kid/Karen/Worker Day 2 (last one end_of_day → 7)
# Day 3 (shuffled, only un-rested):
#   7-10: remaining ghosts Day 3 (last one end_of_day → 11)
# Day 4 (shuffled, only un-rested + Maintenance Guy):
#   11+: remaining ghosts Day 4 + Maintenance Guy (last one end_of_day → next)
# Day 5 (final):
#   Final resolution
var DIALOGUES = []

var _s
var _w
var _k
var _kid
var _maint

func _ready():
	_s = StudentDialogue.new()
	_w = WorkerDialogue.new()
	_k = KarenDialogue.new()
	_kid = KidDialogue.new()
	_maint = MaintenanceDialogue.new()
	
	_build_dialogues()
	
	await get_tree().process_frame
	get_tree().get_first_node_in_group("dialog_box").start(DIALOGUES[0])


func _build_dialogues():
	DIALOGUES = []
	
	# ── Day 1: Fixed order ──
	DIALOGUES.append(_s.day1)   # 0
	DIALOGUES.append(_w.day1)   # 1
	DIALOGUES.append(_k.day1)   # 2 (end_of_day → 3)
	
	# ── Day 2: Shuffled order ──
	var day2_chars = [
		{"name": "student", "data": _s.day2},
		{"name": "kid", "data": _kid.day2},
		{"name": "karen", "data": _k.day2},
		{"name": "worker", "data": _w.day2}
	]
	day2_chars.shuffle()
	
	var day2_indices = []
	for i in range(day2_chars.size()):
		DIALOGUES.append(day2_chars[i]["data"])
		day2_indices.append(DIALOGUES.size() - 1)
	
	# Patch all day2 exits: intermediate → next char, last → end_of_day
	for i in range(day2_indices.size()):
		if i < day2_indices.size() - 1:
			_patch_leave(day2_indices[i], day2_indices[i + 1])
		else:
			_patch_exit(day2_indices[i], "end_of_day", 2, DIALOGUES.size())
	
	# ── Day 3: Shuffled, only un-rested ghosts ──
	var day3_chars = []
	if not Global.student_rested:
		day3_chars.append({"name": "student", "data": _s.day3})
	if not Global.kid_rested:
		day3_chars.append({"name": "kid", "data": _kid.day3})
	if not Global.karen_rested:
		day3_chars.append({"name": "karen", "data": _k.day3})
	if not Global.worker_rested:
		day3_chars.append({"name": "worker", "data": _w.day3})
	day3_chars.shuffle()
	
	var day3_indices = []
	for i in range(day3_chars.size()):
		DIALOGUES.append(day3_chars[i]["data"])
		day3_indices.append(DIALOGUES.size() - 1)
	
	# Patch all day3 exits
	for i in range(day3_indices.size()):
		if i < day3_indices.size() - 1:
			_patch_leave(day3_indices[i], day3_indices[i + 1])
		else:
			_patch_exit(day3_indices[i], "end_of_day", 3, DIALOGUES.size())
	
	# ── Day 4: Shuffled, only un-rested ghosts + Maintenance Guy ──
	var day4_chars = []
	if not Global.student_rested:
		day4_chars.append({"name": "student", "data": _s.day4})
	if not Global.kid_rested:
		day4_chars.append({"name": "kid", "data": _kid.day4})
	if not Global.karen_rested:
		day4_chars.append({"name": "karen", "data": _k.day4})
	if not Global.worker_rested:
		day4_chars.append({"name": "worker", "data": _w.day4})
	# Maintenance Guy always appears on day 4
	day4_chars.append({"name": "maintenance", "data": _maint.day4})
	day4_chars.shuffle()
	
	var day4_indices = []
	for i in range(day4_chars.size()):
		DIALOGUES.append(day4_chars[i]["data"])
		day4_indices.append(DIALOGUES.size() - 1)
	
	# Patch all day4 exits
	for i in range(day4_indices.size()):
		if i < day4_indices.size() - 1:
			_patch_leave(day4_indices[i], day4_indices[i + 1])
		else:
			_patch_exit(day4_indices[i], "end_of_day", 4, DIALOGUES.size())
	
	# ── Day 5: Final resolution ──
	DIALOGUES.append(_build_day5())


# Patch the last entry of a dialogue array to transition properly
func _patch_exit(dialogue_index: int, exit_type: String, day_number: int, next_index: int):
	var arr = DIALOGUES[dialogue_index]
	var last = arr[arr.size() - 1]
	last["type"] = exit_type
	last["day_number"] = day_number
	last["next_day_dialogue_index"] = next_index

# Patch the last entry to leave to the next character
func _patch_leave(dialogue_index: int, next_dialogue_index: int):
	var arr = DIALOGUES[dialogue_index]
	var last = arr[arr.size() - 1]
	last["type"] = "leave_and_next_char"
	last["next_dialogue"] = next_dialogue_index


# ── Day 5: Final resolution ───────────────────────────────────────────────────
func _build_day5():
	var portrait = _w.portrait
	return [
		{
			"name": "You",
			"portrait": portrait,
			"text": "\"...It's quiet now. No one comes anymore.\"",
			"type": "dialogue",
			"next_entry_index": 1
		},
		{
			"name": "You",
			"portrait": portrait,
			"text": "\"The student. The kid. Karen. The office lady. They're all gone now.\"",
			"type": "dialogue",
			"next_entry_index": 2
		},
		{
			"name": "You",
			"portrait": portrait,
			"text": "\"I served them all. Even when I knew they weren't really there.\"",
			"type": "dialogue",
			"next_entry_index": 3
		},
		{
			"name": "You",
			"portrait": portrait,
			"text": "\"But that's what I do. That's what I've always done.\"",
			"type": "dialogue",
			"next_entry_index": 4
		},
		{
			"name": "You",
			"portrait": portrait,
			"text": "\"And maybe... that's enough.\"",
			"type": "dialogue",
			"next_entry_index": 5
		},
		{
			"name": "You",
			"portrait": portrait,
			"text": "*The maintenance guy said he'd be back. He always comes back.*",
			"type": "dialogue",
			"next_entry_index": 6
		},
		{
			"name": "You",
			"portrait": portrait,
			"text": "\"...I'll be here. Waiting. Ready to serve.\"",
			"type": "dialogue",
			"next_entry_index": 7
		},
		{
			"name": "You",
			"portrait": portrait,
			"text": "",
			"type": "end_of_day",
			"day_number": 5,
			"next_day_dialogue_index": -1
		}
	]