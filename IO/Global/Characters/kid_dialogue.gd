extends Node

var portrait = preload("res://Assets/Characters/IO-Kid_Default.png")

# ── Day 2 ─────────────────────────────────────────────────────────────────────
# The Kid appears after Student Day 2. They're restless, kicking the machine.
var day2 = [
	{
		"name": "Kid",
		"portrait": portrait,
		"text": "*A small kid walks up and stares at you.*",
		"type": "dialogue",
		"next_entry_index": 1
	},
	{
		"name": "Kid",
		"portrait": portrait,
		"text": "Mr. Machine... can I have a snack?",
		"type": "dialogue",
		"next_entry_index": 2
	},
	{
		"name": "You",
		"portrait": portrait,
		"text": "\"A kid? Out here alone?\"",
		"type": "dialogue",
		"next_entry_index": 3
	},
	{
		"name": "Kid",
		"portrait": portrait,
		"text": "My mom said I'm not supposed to talk to strangers... but you're not a person, right? You're just a machine.",
		"type": "option",
		"option_1_text": "That's right, just a machine.",
		"option_2_text": "I'm more than that.",
		"option_next_indices": [4, 5],
		"option_likeable_points": [0, 1]
	},
	{
		"name": "Kid",
		"portrait": portrait,
		"text": "Okay good! Then you won't mind if I take something?",
		"type": "dialogue",
		"next_entry_index": 6
	},
	{
		"name": "Kid",
		"portrait": portrait,
		"text": "Huh? More than a machine? That's weird. But cool!",
		"type": "dialogue",
		"next_entry_index": 6
	},
	{
		"name": "Kid",
		"portrait": portrait,
		"text": "I want something sweet! Give me the yummiest thing you have!",
		"type": "request",
		"request_items": ["Candy", "Juice Box", "Soda"],
		"bad_item": "Coffee",
		"request_success_entry_index": 7,
		"request_failure_entry_index": 9,
		"request_bad_option_entry_index": 10,
		"request_deny_entry_index": 12,
		"request_likeable_points_success": 2,
		"request_likeable_points_failure": -1,
		"request_likeable_points_bad": -3,
		"request_likeable_points_deny": -2
	},
	{
		"name": "Kid",
		"portrait": portrait,
		"text": "Yay! *He grabs it happily.* You're my favorite machine!",
		"type": "dialogue",
		"next_entry_index": 8
	},
	{
		"name": "Kid",
		"portrait": portrait,
		"text": "*He runs off with the snack.*",
		"type": "dialogue",
		"next_entry_index": 14
	},
	{
		"name": "Kid",
		"portrait": portrait,
		"text": "*He pouts.* This isn't what I wanted... but I guess it's okay.",
		"type": "dialogue",
		"next_entry_index": 14
	},
	{
		"name": "Kid",
		"portrait": portrait,
		"text": "Ew, coffee?! That's gross! *He pushes it back into the slot, jamming it.*",
		"type": "dialogue",
		"next_entry_index": 11
	},
	{
		"name": "Kid",
		"portrait": portrait,
		"text": "*He kicks the machine in frustration.*",
		"type": "dialogue",
		"next_entry_index": 14
	},
	{
		"name": "Kid",
		"portrait": portrait,
		"text": "*He looks at you with big eyes.* Please?",
		"type": "dialogue",
		"next_entry_index": 13
	},
	{
		"name": "Kid",
		"portrait": portrait,
		"text": "*He waits a moment, then slowly walks away.*",
		"type": "dialogue",
		"next_entry_index": 14
	},
	{
		"name": "You",
		"portrait": portrait,
		"text": "\"A kid wandering around... this place isn't what it used to be.\"",
		"type": "dialogue",
		"next_entry_index": 15
	},
	{
		"name": "You",
		"portrait": portrait,
		"text": "",
		"type": "leave_and_next_char",
		"next_dialogue": 5
	}
]

# ── Day 3 ─────────────────────────────────────────────────────────────────────
# The Kid comes back. They're scared. They finally understand.
var day3 = [
	{
		"name": "Kid",
		"portrait": portrait,
		"text": "*The kid walks up slowly. No running. No bouncing.*",
		"type": "dialogue",
		"next_entry_index": 1
	},
	{
		"name": "Kid",
		"portrait": portrait,
		"text": "Mr. Machine... I can't find my mom.",
		"type": "dialogue",
		"next_entry_index": 2
	},
	{
		"name": "You",
		"portrait": portrait,
		"text": "\"Where did you last see her?\"",
		"type": "dialogue",
		"next_entry_index": 3
	},
	{
		"name": "Kid",
		"portrait": portrait,
		"text": "I don't remember. I've been walking for so long. The streets all look the same.",
		"type": "dialogue",
		"next_entry_index": 4
	},
	{
		"name": "Kid",
		"portrait": portrait,
		"text": "And... and I keep seeing people who look like they're sleeping. But they're not moving. They're not breathing.",
		"type": "dialogue",
		"next_entry_index": 5
	},
	{
		"name": "You",
		"portrait": portrait,
		"text": "\"...Kid. Do you remember what happened? Before you started walking?\"",
		"type": "dialogue",
		"next_entry_index": 6
	},
	{
		"name": "Kid",
		"portrait": portrait,
		"text": "*He thinks hard. His face goes pale.*",
		"type": "dialogue",
		"next_entry_index": 7
	},
	{
		"name": "Kid",
		"portrait": portrait,
		"text": "There was... a car. And my mom was holding my hand. And then...",
		"type": "dialogue",
		"next_entry_index": 8
	},
	{
		"name": "Kid",
		"portrait": portrait,
		"text": "*He starts to cry.* I'm not supposed to be here, am I?",
		"type": "dialogue",
		"next_entry_index": 9
	},
	{
		"name": "You",
		"portrait": portrait,
		"text": "\"...I'm sorry, kid.\"",
		"type": "dialogue",
		"next_entry_index": 10
	},
	{
		"name": "Kid",
		"portrait": portrait,
		"text": "Can I have one more snack? Before I go?",
		"type": "request",
		"request_items": ["Candy", "Juice Box", "Soda", "Chips"],
		"request_success_entry_index": 11,
		"request_failure_entry_index": 12,
		"request_deny_entry_index": 12,
		"request_likeable_points_success": 3,
		"request_likeable_points_failure": -1,
		"request_likeable_points_deny": -2
	},
	{
		"name": "Kid",
		"portrait": portrait,
		"text": "*He takes it and holds it close. He doesn't eat it. He just holds it.*",
		"type": "dialogue",
		"next_entry_index": 13
	},
	{
		"name": "Kid",
		"portrait": portrait,
		"text": "*He looks at the snack, then at you. He smiles through tears.*",
		"type": "dialogue",
		"next_entry_index": 13
	},
	{
		"name": "Kid",
		"portrait": portrait,
		"text": "Thank you, Mr. Machine. I think I can find my mom now.",
		"type": "dialogue",
		"next_entry_index": 14
	},
	{
		"name": "Kid",
		"portrait": portrait,
		"text": "*He walks away, holding the snack. He fades before he reaches the corner.*",
		"type": "dialogue",
		"next_entry_index": 15
	},
	{
		"name": "You",
		"portrait": portrait,
		"text": "\"...Goodbye, little one.\"",
		"type": "dialogue",
		"next_entry_index": 16
	},
	{
		"name": "You",
		"portrait": portrait,
		"text": "",
		"type": "leave_and_next_char",
		"next_dialogue": 9
	}
]

# ── Day 4 ─────────────────────────────────────────────────────────────────────
# The Kid comes back if he hasn't rested yet. He's more aware now.
var day4 = [
	{
		"name": "Kid",
		"portrait": portrait,
		"text": "*The kid walks up. He looks... clearer. More solid.*",
		"type": "dialogue",
		"next_entry_index": 1
	},
	{
		"name": "Kid",
		"portrait": portrait,
		"text": "Mr. Machine... I found my mom.",
		"type": "dialogue",
		"next_entry_index": 2
	},
	{
		"name": "You",
		"portrait": portrait,
		"text": "\"...You did?\"",
		"type": "dialogue",
		"next_entry_index": 3
	},
	{
		"name": "Kid",
		"portrait": portrait,
		"text": "She was waiting for me. She said I've been walking for a really long time.",
		"type": "dialogue",
		"next_entry_index": 4
	},
	{
		"name": "Kid",
		"portrait": portrait,
		"text": "She said... I can go home now. But I wanted to say goodbye to you first.",
		"type": "dialogue",
		"next_entry_index": 5
	},
	{
		"name": "You",
		"portrait": portrait,
		"text": "\"...You remembered me?\"",
		"type": "dialogue",
		"next_entry_index": 6
	},
	{
		"name": "Kid",
		"portrait": portrait,
		"text": "Of course! You gave me snacks! You were nice to me!",
		"type": "dialogue",
		"next_entry_index": 7
	},
	{
		"name": "Kid",
		"portrait": portrait,
		"text": "Can I have one more? For the road?",
		"type": "request",
		"request_items": ["Candy", "Juice Box", "Soda", "Chips"],
		"request_success_entry_index": 8,
		"request_failure_entry_index": 9,
		"request_deny_entry_index": 9,
		"request_likeable_points_success": 2,
		"request_likeable_points_failure": -1,
		"request_likeable_points_deny": -2
	},
	{
		"name": "Kid",
		"portrait": portrait,
		"text": "*He takes it and hugs it.* Thank you, Mr. Machine!",
		"type": "dialogue",
		"next_entry_index": 10
	},
	{
		"name": "Kid",
		"portrait": portrait,
		"text": "*He looks at you sadly.* It's okay. I'll be okay.",
		"type": "dialogue",
		"next_entry_index": 10
	},
	{
		"name": "Kid",
		"portrait": portrait,
		"text": "Bye bye, Mr. Machine! I'll tell my mom about you!",
		"type": "dialogue",
		"next_entry_index": 11
	},
	{
		"name": "Kid",
		"portrait": portrait,
		"text": "*He runs off, waving. He fades into the light.*",
		"type": "dialogue",
		"next_entry_index": 12
	},
	{
		"name": "You",
		"portrait": portrait,
		"text": "\"...Goodbye, little one.\"",
		"type": "dialogue",
		"next_entry_index": 13
	},
	{
		"name": "You",
		"portrait": portrait,
		"text": "",
		"type": "leave_and_next_char",
		"next_dialogue": -1
	}
]
