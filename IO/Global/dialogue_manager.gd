extends Node

#dialogue manager
var dialogue_sample = [
{
	"name": "Student",
	"portrait": preload("res://Assets/Characters/IO-OfficeLady_NonGlossed_NoMakeup.png"),
	"text": "I want to apologize… but gently.",
	
	# type: "dialogue", "request", "option"
	"type": "dialogue",

	# For dialogue / assemble
	"next_entry_index": 1,

	# For option type only
	"option_1_text": null,
	"option_2_text": null,
	"option_next_indices": null,

	# For request type only
	"request_items": null,
	"bad_item": null,
	"request_success_entry_index": null,
	"request_failure_entry_index": null,
	"request_bad_option_entry_index": null,
	"request_deny_entry_index": null,
}
]

var student_day_1 = [
	{
		"name": "Student",
		"portrait": preload("res://Assets/Characters/IO-Student_NonGlossed.png"),
		"text": "A new vending machine in town?",
		"type": "dialogue",
		"next_entry_index": 1
	},
	{
		"name": "Student",
		"portrait": preload("res://Assets/Characters/IO-Student_NonGlossed.png"),
		"text": "Hey Mr. Vending Machine, I want something to eat before i head to class. Instant Noodles.",
		"type": "option",
		"option_1_text": "What a demanding student....",
		"option_2_text": "Hello!",
		"option_next_indices": [2, 3]
	},
	{
		"name": "Student",
		"portrait": preload("res://Assets/Characters/IO-Student_NonGlossed.png"),
		"text": "And who taught machines to talk back anyway? That's... kind of creepy.",
		"type": "dialogue",
		"next_entry_index": 4
	},
	{
		"name": "Student",
		"portrait": preload("res://Assets/Characters/IO-Student_NonGlossed.png"),
		"text": ".... You're sentient..? That's... kind of cool, I guess.",
		"type": "dialogue",
		"next_entry_index": 4
	},
	{
		"name": "System",
		"portrait": preload("res://Assets/Characters/IO-Student_NonGlossed.png"),
		"text": "On the right side, select an item that matches what the student is asking for. You can also select the 'Deny' option if you don't want to give them anything.",
		"type": "request",
		"request_items": ["Instant Noodles"],
		"request_success_entry_index": 5,
		"request_failure_entry_index": 6,
		"request_deny_entry_index": 7,
	},
	{
		#success
		"name": "Student",
		"portrait": preload("res://Assets/Characters/IO-Student_NonGlossed.png"),
		"text": "You're a good machine! This will fill me up for class.",
		"type": "dialogue",
		"next_entry_index": 8
	},
	{
		#failure
		"name": "Student",
		"portrait": preload("res://Assets/Characters/IO-Student_NonGlossed.png"),
		"text": "This machine talks back... but it won't even give me what I want? That's disappointing.",
		"type": "dialogue",
		"next_entry_index": 8
	},
	{
		#denied
		"name": "Student",
		"portrait": preload("res://Assets/Characters/IO-Student_NonGlossed.png"),
		"text": "Rubbish. No wonder i never saw anyone use this machine.",
		"type": "dialogue",
		"next_entry_index": 8
	}
]

var worker_day1 = [
	{
		"name": "Office Lady",
		"portrait": preload("res://Assets/Characters/IO-OfficeLady_NonGlossed_NoMakeup.png"),
		"text": "Hello, I'm in a hurry here.... One Coffee Please",
		"type": "request",
		"request_items": ["Coffee"],
		"request_success_entry_index": 1,
		"request_failure_entry_index": 2,
		"request_deny_entry_index": 3,
	},
	{
		#success
		"name": "Office Lady",
		"portrait": preload("res://Assets/Characters/IO-OfficeLady_NonGlossed_NoMakeup.png"),
		"text": "Oh! Thank you.",
		"type": "dialogue",
		"next_entry_index": 5
	},
	{
		#failure
		"name": "Office Lady",
		"portrait": preload("res://Assets/Characters/IO-OfficeLady_NonGlossed_NoMakeup.png"),
		"text": "You got guts, No time to complain anyways, Thanks regardless",
		"type": "dialogue",
		"next_entry_index": 5
	},
	{
		#denied
		"name": "Office Lady",
		"portrait": preload("res://Assets/Characters/IO-OfficeLady_NonGlossed_NoMakeup.png"),
		"text": "Oh well, That sucks, Thank you machine.",
		"type": "dialogue",
		"next_entry_index": 4
	},
	{
		#denied
		"name": "You",
		"portrait": preload("res://Assets/Characters/IO-OfficeLady_NonGlossed_NoMakeup.png"),
		"text": "\"Thank You? But i....\"",
		"type": "dialogue",
		"next_entry_index": 5
	},
	{
		#thought
		"name": "You",
		"portrait": preload("res://Assets/Characters/IO-OfficeLady_NonGlossed_NoMakeup.png"),
		"text": "\"Whatever i do... Looks like her response will be receptive..., Something tells me \"",
		"type": "dialogue",
		"next_entry_index": 5
	}
	
	
]
func _ready():
	await get_tree().process_frame
	get_tree().get_first_node_in_group("dialog_box").start(worker_day1)
