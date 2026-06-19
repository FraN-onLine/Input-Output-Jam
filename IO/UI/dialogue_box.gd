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
@onready var day_complete_label: Label = $DayCompleteLabel
@onready var day_number_top: Label = $DayNumberTop
@onready var day_number_bottom: Label = $DayNumberBottom

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
var _transition_tween: Tween

func _ready() -> void:
	portrait_default_pos = portrait.position
	portrait_offscreen_right = portrait_default_pos + Vector2(700, 0)
	portrait_offscreen_left = portrait_default_pos + Vector2(-700, 0)
	_update_good_points_display()
	day_complete_label.visible = false
	day_number_top.visible = false
	day_number_bottom.visible = false

func start(dialogue_array: Array, start_index := 0) -> void:
	dialogue_data = dialogue_array
	current_index = start_index
	# Reset fade in case we came from end_of_day
	fade.visible = true
	var t := create_tween()
	t.tween_property(fade, "modulate:a", 0.0, 0.01)
	t.tween_callback(func():
		fade.visible = false
		_show_entry()
		_update_good_points_display()
	)


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

	# For end_of_day, skip to transition immediately (no typing, no buttons)
	if current_entry.get("type") == "end_of_day":
		_handle_end_of_day()
		return

	# Normal flow: typing + buttons for everything else
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
			# Text shows with typing. Next button appears so player reads it.
			next_button.visible = true

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

	# After typing finishes, auto-resolve branching
	if current_entry.get("type") == "branching":
		_resolve_branching()


func _set_buttons_disabled(disabled: bool) -> void:
	next_button.disabled = disabled
	option_1.disabled = disabled
	option_2.disabled = disabled
	for i in $Items.get_children():
		i.disabled = false


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

	var likeable_pts = current_entry.get("option_likeable_points", [])
	if option_idx < likeable_pts.size():
		Global.Good_Points += likeable_pts[option_idx]
		_update_good_points_display()

	_go_to_next(indices[option_idx])


# ── Branching Type ────────────────────────────────────────────────────────────
func _resolve_branching() -> void:
	var min_points = current_entry.get("branch_min_points", 0)
	var success_idx = current_entry.get("branch_success_entry_index", -1)
	var failure_idx = current_entry.get("branch_failure_entry_index", -1)

	if Global.Good_Points >= min_points:
		_go_to_next(success_idx)
	else:
		_go_to_next(failure_idx)


# ── Request Type ──────────────────────────────────────────────────────────────
func on_vended_item_pressed(item):
	var selected_item = item
	var request_items = current_entry.get("request_items", [])

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


# ── Leave & Next Character ────────────────────────────────────────────────────
func _handle_leave_next_char() -> void:
	var next_dialogue_in = current_entry.get("next_dialogue", [])
	var next_dialogue = DialogueManager.DIALOGUES[next_dialogue_in]

	_portrait_exit(func():
		_fade_out_in(func():
			start(next_dialogue, 0)
		)
	)


# ── End of Day Type ───────────────────────────────────────────────────────────
# Smooth day transition using a single persistent tween chain:
#   1. Portrait slides out (0.5s)
#   2. Fade to black (0.8s)
#   3. Show "Day X Complete" + remark (fade in 0.5s)
#   4. Hold 2.5s
#   5. Fade out text (0.5s)
#   6. Number drop: old falls down, new drops in (0.8s)
#   7. Fade out black → next day
func _handle_end_of_day() -> void:
	var day_number = current_entry.get("day_number", 1)
	var next_day_idx = current_entry.get("next_day_dialogue_index", -1)

	# Determine remark based on Good_Points
	var remark = ""
	if Global.Good_Points <= -3:
		remark = "\"You're kind of a scrap they say you are...\""
	elif Global.Good_Points <= 1:
		remark = "\"Eh... Could've been worse.\""
	else:
		remark = "\"Good day.\""

	_portrait_exit(func():
		# Use a single persistent tween for the entire transition
		_transition_tween = create_tween()
		
		# Step 1: Fade to black
		fade.visible = true
		fade.modulate = Color(0, 0, 0, 0)
		_transition_tween.tween_property(fade, "modulate:a", 1.0, 0.8)
		
		# Step 2: Hide UI, show "Day Complete" text
		_transition_tween.tween_callback(func():
			portrait.visible = false
			name_label.visible = false
			dialog_label.visible = false
			next_button.visible = false
			option_1.visible = false
			option_2.visible = false
			good_points_label.visible = false
			for i in $Items.get_children():
				i.visible = false
			
			day_complete_label.visible = true
			day_complete_label.text = "Day " + str(day_number) + " Complete\n" + remark
			day_complete_label.modulate = Color(1, 1, 1, 0)
		)
		
		# Step 3: Fade in text
		_transition_tween.tween_property(day_complete_label, "modulate:a", 1.0, 0.5)
		
		# Step 4: Hold
		_transition_tween.tween_interval(2.5)
		
		# Step 5: Fade out text
		_transition_tween.tween_property(day_complete_label, "modulate:a", 0.0, 0.5)
		
		# Step 6: Number drop animation
		_transition_tween.tween_callback(func():
			day_complete_label.visible = false
			
			if next_day_idx < 0 or next_day_idx >= DialogueManager.DIALOGUES.size():
				queue_free()
				return
			
			var next_day = next_day_idx + 1
			
			# Old day number at center
			day_number_bottom.text = str(day_number)
			day_number_bottom.visible = true
			day_number_bottom.position = Vector2(0, 0)
			day_number_bottom.modulate = Color(1, 1, 1, 1)
			
			# New day number above screen
			day_number_top.text = str(next_day)
			day_number_top.visible = true
			day_number_top.position = Vector2(0, -200)
			day_number_top.modulate = Color(1, 1, 1, 1)
			
			# Animate both simultaneously
			var number_tween := create_tween()
			number_tween.set_parallel(true)
			number_tween.tween_property(day_number_bottom, "position:y", 400, 0.8).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_BACK)
			number_tween.tween_property(day_number_top, "position:y", 0, 0.8).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
			
			# Step 7: After numbers animate, restore UI and fade out black
			number_tween.tween_callback(func():
				day_number_bottom.visible = false
				day_number_top.visible = false
				
				portrait.visible = true
				name_label.visible = true
				dialog_label.visible = true
				good_points_label.visible = true
				for i in $Items.get_children():
					i.visible = true
				
				start(DialogueManager.DIALOGUES[next_day_idx], 0)
			)
		)
	)


# ── Transition Helpers ────────────────────────────────────────────────────────
func _fade_out_in(callback: Callable) -> void:
	var t := create_tween()
	t.tween_property(fade, "modulate:a", 1.0, 0.4)
	t.tween_callback(callback)
	t.tween_property(fade, "modulate:a", 0.0, 0.4)


func _portrait_enter() -> void:
	portrait.position = portrait_offscreen_right
	var t := create_tween()
	t.tween_property(portrait, "position", portrait_default_pos, 0.5)


func _portrait_exit(callback: Callable) -> void:
	var t := create_tween()
	t.tween_property(portrait, "position", portrait_offscreen_left, 0.5)
	t.tween_callback(callback)