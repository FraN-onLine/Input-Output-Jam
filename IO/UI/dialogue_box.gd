extends CanvasLayer

signal assemble_requested(entry_index: int)

@onready var portrait: TextureRect = $Portrait
@onready var name_label: Label = $Name
@onready var dialog_label: RichTextLabel = $Dialog

@onready var next_button: Button = $Next
@onready var option_1: Button = $Option1
@onready var option_2: Button = $Option2

@onready var fade: ColorRect = $Fade
@onready var good_points_label: Label = $GoodPointsLabel

var dialogue_data: Array = []
var current_index: int = 0
var current_entry: Dictionary

var portrait_default_pos: Vector2
var portrait_offscreen_right: Vector2
var portrait_offscreen_left: Vector2

@export var typing_speed := 0.03 # seconds per character

var _full_text: String = ""
var _typing := false
var _typing_tween: Tween

func _ready() -> void:
	portrait_default_pos = portrait.position
	portrait_offscreen_right = portrait_default_pos + Vector2(700, 0)
	portrait_offscreen_left = portrait_default_pos + Vector2(-700, 0)
	_update_good_points_display()

func start(dialogue_array: Array, start_index := 0) -> void:
	dialogue_data = dialogue_array
	current_index = start_index
	_show_entry()
	_update_good_points_display()


func _show_entry() -> void:
	if current_index < 0 or current_index >= dialogue_data.size():
		queue_free()
		return

	current_entry = dialogue_data[current_index]

	# Populate UI
	name_label.text = current_entry.get("name", "")
	dialog_label.text = current_entry.get("text", "")
	portrait.texture = current_entry.get("portrait", null)
	if current_index == 0:
		_portrait_enter()

	# ADD: start typing instead of instant text
	_start_typing(current_entry.get("text", ""))

	_update_buttons()


func _update_buttons() -> void:
	next_button.visible = false
	option_1.visible = false
	option_2.visible = false
	for i in $Items.get_children():
				i.disabled = true

	match current_entry.get("type", "dialogue"):
		"dialogue":
			next_button.visible = true

		"option":
			option_1.visible = true
			option_2.visible = true

			option_1.text = current_entry.get("option_1_text", "Option 1")
			option_2.text = current_entry.get("option_2_text", "Option 2")
			
		"branching":
			# Branching checks Good_Points threshold, automatically navigates
			# No buttons needed — auto-resolves after typing finishes
			pass
			
		"request":
			for i in $Items.get_children():
				i.disabled = false
		"leave_and_next_char":
			_handle_leave_next_char()
			return


# Typing fx
func _start_typing(text: String) -> void:
	if _typing_tween and _typing_tween.is_running():
		_typing_tween.kill()

	_full_text = text
	dialog_label.text = ""
	_typing = true

	_typing_tween = create_tween()
	for i in _full_text.length():
		_typing_tween.tween_callback(
			func():
				dialog_label.text += _full_text[i]
		).set_delay(typing_speed)

	_typing_tween.tween_callback(_finish_typing)



func _finish_typing() -> void:
	_typing = false
	dialog_label.text = _full_text
	
	# If this is a branching type, auto-resolve after typing finishes
	if current_entry.get("type") == "branching":
		_resolve_branching()


func _set_buttons_disabled(disabled: bool) -> void:
	next_button.disabled = disabled
	option_1.disabled = disabled
	option_2.disabled = disabled
	for i in $Items.get_children():
				i.disabled = false

# Update the Good_Points counter in the top-right corner
func _update_good_points_display() -> void:
	good_points_label.text = "Reputation: " + str(Global.Good_Points)

func _skip_typing_if_needed() -> bool:
	if _typing:
		if _typing_tween:
			_typing_tween.kill()
		_finish_typing()
		return true
	return false


func _on_Next_pressed() -> void:
	if _skip_typing_if_needed():
		return
	_go_to_next(current_entry.get("next_entry_index", -1))


func _on_Option1_pressed() -> void:
	if _skip_typing_if_needed():
		return
	_select_option(0)


func _on_Option2_pressed() -> void:
	if _skip_typing_if_needed():
		return
	_select_option(1)


func _select_option(option_idx: int) -> void:

	var indices = current_entry.get("option_next_indices", [])
	if option_idx >= indices.size():
		return
	
	# Apply likeable_points for this option if present
	var likeable_pts = current_entry.get("option_likeable_points", [])
	if option_idx < likeable_pts.size():
		Global.Good_Points += likeable_pts[option_idx]
		_update_good_points_display()
	
	_go_to_next(indices[option_idx])


# ── Branching Type ────────────────────────────────────────────────────────────
# "branching" auto-navigates based on Good_Points threshold.
# Example entry:
# {
#     "name": "You",
#     "portrait": portrait,
#     "text": "The kid's kicks are getting fiercer. Do I stand my ground?",
#     "type": "branching",
#     "branch_min_points": 2,          # if Good_Points >= this → success
#     "branch_success_entry_index": 3, # goes here if threshold met
#     "branch_failure_entry_index": 5  # goes here if threshold not met
# }
func _resolve_branching() -> void:
	var min_points = current_entry.get("branch_min_points", 0)
	var success_idx = current_entry.get("branch_success_entry_index", -1)
	var failure_idx = current_entry.get("branch_failure_entry_index", -1)
	
	if Global.Good_Points >= min_points:
		_go_to_next(success_idx)
	else:
		_go_to_next(failure_idx)


# ── Request Type ──────────────────────────────────────────────────────────────
# "request" entries now support per-outcome likeable_points:
# {
#     "type": "request",
#     "request_items": ["Instant Noodles"],
#     "request_success_entry_index": 5,
#     "request_failure_entry_index": 6,
#     "request_deny_entry_index": 7,
#     "request_likeable_points_success": 2,   # Good_Points added on correct item
#     "request_likeable_points_failure": -1,  # Good_Points added on wrong item
#     "request_likeable_points_deny": -2      # Good_Points added on deny
# }
# 
# Also supports bad_item for special "wrong" outcomes:
# {
#     "bad_item": "Expired Milk",
#     "request_bad_option_entry_index": 4,
#     "request_likeable_points_bad": -3
# }

#buttons with text
func on_vended_item_pressed(item):
	#get text of button pressed
	var selected_item = item
	var request_items = current_entry.get("request_items", [])
	
	# Apply likeable_points for request outcomes
	var success_pts = current_entry.get("request_likeable_points_success", 1)
	var failure_pts = current_entry.get("request_likeable_points_failure", -1)
	var bad_pts = current_entry.get("request_likeable_points_bad", -3)
	
	if selected_item in request_items:
		Global.Good_Points += success_pts
		_update_good_points_display()
		_go_to_next(current_entry.get("request_success_entry_index", -1))
	elif selected_item == current_entry.get("bad_item", ""):
		Global.Good_Points += bad_pts
		_update_good_points_display()
		_go_to_next(current_entry.get("request_bad_option_entry_index", -1))
	else:
		Global.Good_Points += failure_pts
		_update_good_points_display()
		_go_to_next(current_entry.get("request_failure_entry_index", -1))

func on_deny_pressed():
	var deny_pts = current_entry.get("request_likeable_points_deny", -2)
	Global.Good_Points += deny_pts
	_update_good_points_display()
	_go_to_next(current_entry.get("request_deny_entry_index", -1))

func _go_to_next(next_index: int) -> void:
	if next_index == -1:
		queue_free()
		return

	current_index = next_index
	_show_entry()

func _fade_out_in(callback: Callable) -> void:
	var t := create_tween()

	t.tween_property(fade, "modulate:a", 1.0, 0.4)
	t.tween_callback(callback)
	t.tween_property(fade, "modulate:a", 0.0, 0.4)

func _handle_leave_next_char() -> void:
	var next_dialogue_in = current_entry.get("next_dialogue", [])
	var next_dialogue = DialogueManager.DIALOGUES[next_dialogue_in]

	_portrait_exit(func():
		_fade_out_in(func():
			start(next_dialogue, 0)
		)
	)

func _portrait_enter() -> void:
	portrait.position = portrait_offscreen_right

	var t := create_tween()
	t.tween_property(
		portrait,
		"position",
		portrait_default_pos,
		0.5
	)

func _portrait_exit(callback: Callable) -> void:
	var t := create_tween()

	t.tween_property(
		portrait,
		"position",
		portrait_offscreen_left,
		0.5
	)

	t.tween_callback(callback)
