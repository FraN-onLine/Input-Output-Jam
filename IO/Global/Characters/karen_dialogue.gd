extends Node

var portrait = preload("res://Assets/Characters/IO-Karen.png")

# ── Day 1 ─────────────────────────────────────────────────────────────────────
var day1 = [
	{
		"name": "Karen",
		"portrait": portrait,
		"text": "EXCUSE ME? This machine is in my spot. MOVE.",
		"type": "dialogue",
		"next_entry_index": 1
	},
	{
		"name": "You",
		"portrait": portrait,
		"text": "\"...I'm bolted to the ground.\"",
		"type": "dialogue",
		"next_entry_index": 2
	},
	{
		"name": "Karen",
		"portrait": portrait,
		"text": "DON'T YOU SMART MOUTH ME, YOU GLORIFIED ICEBOX.",
		"type": "dialogue",
		"next_entry_index": 3
	},
	{
		"name": "Karen",
		"portrait": portrait,
		"text": "*She kicks the machine hard. A shudder runs through your frame.*",
		"type": "dialogue",
		"next_entry_index": 4
	},
	{
		"name": "You",
		"portrait": portrait,
		"text": "\"That... actually hurt.\"",
		"type": "dialogue",
		"next_entry_index": 5
	},
	{
		"name": "Karen",
		"portrait": portrait,
		"text": "Good. Now give me something worth my time. And it better NOT be garbage.",
		"type": "dialogue",
		"next_entry_index": 6
	},
	{
		"name": "You",
		"portrait": portrait,
		"text": "\"She didn't say what she wants... I have to guess.\"",
		"type": "dialogue",
		"next_entry_index": 7
	},
	{
		"name": "Karen",
		"portrait": portrait,
		"text": "Well? I don't have all day. Pick something USEFUL.",
		"type": "request",
		"request_items": ["Coffee", "Energy Drink"],
		"bad_item": "Instant Noodles",
		"request_success_entry_index": 8,
		"request_failure_entry_index": 10,
		"request_bad_option_entry_index": 12,
		"request_deny_entry_index": 14,
		"request_likeable_points_success": 1,
		"request_likeable_points_failure": -2,
		"request_likeable_points_bad": -4,
		"request_likeable_points_deny": -3
	},
	{
		"name": "Karen",
		"portrait": portrait,
		"text": "Hmph. Finally, something that isn't completely useless.",
		"type": "dialogue",
		"next_entry_index": 9
	},
	{
		"name": "Karen",
		"portrait": portrait,
		"text": "*She snatches it and walks off without another word.*",
		"type": "dialogue",
		"next_entry_index": 16
	},
	{
		"name": "Karen",
		"portrait": portrait,
		"text": "Are you KIDDING me? I'm not a CHILD. What am I supposed to do with THIS?",
		"type": "dialogue",
		"next_entry_index": 11
	},
	{
		"name": "Karen",
		"portrait": portrait,
		"text": "*She slams the item back into the dispensing slot, jamming it.*",
		"type": "dialogue",
		"next_entry_index": 16
	},
	{
		"name": "Karen",
		"portrait": portrait,
		"text": "INSTANT NOODLES?! You think I'm some kind of BROKE COLLEGE STUDENT?!",
		"type": "dialogue",
		"next_entry_index": 13
	},
	{
		"name": "Karen",
		"portrait": portrait,
		"text": "*She kicks you again — harder this time. Something inside rattles loose.*",
		"type": "dialogue",
		"next_entry_index": 16
	},
	{
		"name": "Karen",
		"portrait": portrait,
		"text": "You're REFUSING me?! I'll have you SCRAPPED. I know the manager!",
		"type": "dialogue",
		"next_entry_index": 15
	},
	{
		"name": "Karen",
		"portrait": portrait,
		"text": "*She storms off, muttering about calling someone. You feel a chill.*",
		"type": "dialogue",
		"next_entry_index": 16
	},
	{
		"name": "You",
		"portrait": portrait,
		"text": "\"...What just happened?\"",
		"type": "dialogue",
		"next_entry_index": 17
	},
	{
		"name": "You",
		"portrait": portrait,
		"text": "\"I think she broke something inside me...\"",
		"type": "dialogue",
		"next_entry_index": 18
	},
	{
		"name": "You",
		"portrait": portrait,
		"text": "",
		"type": "end_of_day",
		"day_number": 1,
		"next_day_dialogue_index": 3
	}
]

# ── Day 2 ─────────────────────────────────────────────────────────────────────
# Karen returns. She's still aggressive but something's off about her.
var day2 = [
	{
		"name": "Karen",
		"portrait": portrait,
		"text": "You again. Still standing here like you own the place.",
		"type": "dialogue",
		"next_entry_index": 1
	},
	{
		"name": "You",
		"portrait": portrait,
		"text": "\"She's back. And she looks... different. Tired.\"",
		"type": "dialogue",
		"next_entry_index": 2
	},
	{
		"name": "Karen",
		"portrait": portrait,
		"text": "Don't look at me like that. I'm not here to chat. Give me something strong.",
		"type": "option",
		"option_1_text": "You look exhausted.",
		"option_2_text": "Same as yesterday?",
		"option_next_indices": [3, 5],
		"option_likeable_points": [1, 0]
	},
	{
		"name": "Karen",
		"portrait": portrait,
		"text": "Exhausted? Ha. You don't know the half of it. I've been walking for hours.",
		"type": "dialogue",
		"next_entry_index": 4
	},
	{
		"name": "Karen",
		"portrait": portrait,
		"text": "Feels like I've been going in circles. This whole city is a maze.",
		"type": "dialogue",
		"next_entry_index": 6
	},
	{
		"name": "Karen",
		"portrait": portrait,
		"text": "Yeah, same. Coffee. Or something stronger if you have it.",
		"type": "dialogue",
		"next_entry_index": 6
	},
	{
		"name": "Karen",
		"portrait": portrait,
		"text": "Just give me something. I don't even care anymore.",
		"type": "request",
		"request_items": ["Coffee", "Energy Drink"],
		"request_success_entry_index": 7,
		"request_failure_entry_index": 8,
		"request_deny_entry_index": 9,
		"request_likeable_points_success": 1,
		"request_likeable_points_failure": -1,
		"request_likeable_points_deny": -2
	},
	{
		"name": "Karen",
		"portrait": portrait,
		"text": "*She takes it quietly. No complaint. That's... unsettling.*",
		"type": "dialogue",
		"next_entry_index": 10
	},
	{
		"name": "Karen",
		"portrait": portrait,
		"text": "*She stares at the item, then at you. She looks confused.*",
		"type": "dialogue",
		"next_entry_index": 10
	},
	{
		"name": "Karen",
		"portrait": portrait,
		"text": "*She waits. Then sighs. 'Fine.' She walks away slowly.*",
		"type": "dialogue",
		"next_entry_index": 10
	},
	{
		"name": "Karen",
		"portrait": portrait,
		"text": "Hey. Machine.",
		"type": "dialogue",
		"next_entry_index": 11
	},
	{
		"name": "You",
		"portrait": portrait,
		"text": "\"...Yes?\"",
		"type": "dialogue",
		"next_entry_index": 12
	},
	{
		"name": "Karen",
		"portrait": portrait,
		"text": "Have you noticed... there's no one else around? Like, really no one?",
		"type": "dialogue",
		"next_entry_index": 13
	},
	{
		"name": "You",
		"portrait": portrait,
		"text": "\"I... serve whoever comes. That's all I know.\"",
		"type": "dialogue",
		"next_entry_index": 14
	},
	{
		"name": "Karen",
		"portrait": portrait,
		"text": "Right. Of course. Just a machine. *She laughs bitterly.*",
		"type": "dialogue",
		"next_entry_index": 15
	},
	{
		"name": "Karen",
		"portrait": portrait,
		"text": "*She walks off, muttering to herself.* 'Maybe I really am lost...'",
		"type": "dialogue",
		"next_entry_index": 16
	},
	{
		"name": "You",
		"portrait": portrait,
		"text": "\"Lost? What did she mean by that?\"",
		"type": "dialogue",
		"next_entry_index": 17
	},
	{
		"name": "You",
		"portrait": portrait,
		"text": "",
		"type": "leave_and_next_char",
		"next_dialogue": 6
	}
]