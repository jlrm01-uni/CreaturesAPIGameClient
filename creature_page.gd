extends Control

@onready var name_label = $VBoxContainer/HBoxContainer/VBoxContainer/NameLabel
@onready var attack_label = $VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer2/AttackLabel
@onready var creature_texture = $VBoxContainer/HBoxContainer/VBoxContainer/TextureRect

var data: Array
var current_index = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$HTTPRequest.request("http://127.0.0.1:5010/creatures")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_http_request_request_completed(result, response_code, headers, body):
	var json = JSON.parse_string(body.get_string_from_utf8())
	
	data = json
	
	show_creature(data[0])

func show_creature(creature: Dictionary) -> void:
	name_label.text = creature.name
	attack_label.text = "Attack: %s" % creature.attack
	
	var image_name = "res://creatures/creature (%s).png" % creature.image
	creature_texture.texture = load(image_name)

func show_creature_at_index(index: int) -> void:
	current_index = index % data.size()
	
	var creature_data = data[current_index]
	
	show_creature(creature_data)
	
func _on_previous_button_pressed():
	show_creature_at_index(current_index - 1)


func _on_next_button_pressed():
	show_creature_at_index(current_index + 1)
