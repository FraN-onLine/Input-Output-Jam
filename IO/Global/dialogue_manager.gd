extends Node

# ═══════════════════════════════════════════════════════════════════════════════
# DIALOGUE MANAGER — Hub & Documentation
# ═══════════════════════════════════════════════════════════════════════════════
#
# Character dialogues are stored in separate files under Global/Characters/.
# Each file exports `day1`, `day2`, etc. arrays. This hub imports them and builds
# the master DIALOGUES list.
#
# To add a new character:
#   1. Create a new .gd file in Global/Characters/ (copy an existing one)
#   2. Add its preload below
#   3. Append its day arrays to the DIALOGUES list in _ready()
#
# ── Entry Types ───────────────────────────────────────────────────────────────
#
# 1. "dialogue" — Simple text display. Player clicks Next to proceed.
#    Fields: name, portrait, text, type: "dialogue", next_entry_index: int
#
# 2. "option" — Two choices. Each choice can add/subtract Good_Points.
#    Fields: name, portrait, text, type: "option"
#      option_1_text, option_2_text: String
#      option_next_indices: [int, int]
#      option_likeable_points: [int, int] — Good_Points delta per option
#
# 3. "request" — Player selects an item from the vending UI.
#    Fields: name, portrait, text, type: "request"
#      request_items: [String]
#      bad_item: String (optional)
#      request_success/failure/bad_option/deny_entry_index: int
#      request_likeable_points_success/failure/bad/deny: int
#        Defaults if omitted: success=+1, failure=-1, bad=-3, deny=-2
#
# 4. "branching" — Auto-resolves after typing finishes.
#    Checks Global.Good_Points against a threshold.
#    Fields: name, portrait, text, type: "branching"
#      branch_min_points: int
#      branch_success_entry_index: int
#      branch_failure_entry_index: int
#
# 5. "leave_and_next_char" — Transition to next character's dialogue.
#    Fields: name, portrait, text, type: "leave_and_next_char"
#      next_dialogue: int — index into DIALOGUES array
#
# 6. "end_of_day" — Fades to black, shows remark, transitions to next day.
#    Fields: name, portrait, text, type: "end_of_day"
#      day_number: int
#      next_day_dialogue_index: int — dialogue to start next day
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

# ── Master Dialogue List ──────────────────────────────────────────────────────
# Index 0: Student Day 1
# Index 1: Worker Day 1
# Index 2: Karen Day 1  (ends with end_of_day → next_day_dialogue_index: 3)
# Index 3: Student Day 2
# Index 4+: Future days / characters
var DIALOGUES = []

func _ready():
	var s = StudentDialogue.new()
	var w = WorkerDialogue.new()
	var k = KarenDialogue.new()
	
	# Build the list in sequence order
	DIALOGUES = [
		s.day1,   # 0
		w.day1,   # 1
		k.day1,   # 2
		s.day2    # 3
	]
	
	await get_tree().process_frame
	get_tree().get_first_node_in_group("dialog_box").start(DIALOGUES[0])