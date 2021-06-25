extends Node


onready var root = get_tree().root.get_child(1)
onready var Address_LineEdit: LineEdit = root.find_node('Address-LineEdit')
onready var Username_LineEdit: LineEdit = root.find_node('Username-LineEdit')
onready var Chat_LineEdit: LineEdit = root.find_node('Chat-LineEdit')
onready var Chat_TextEdit: TextEdit = root.find_node('Chat-TextEdit')
onready var Send_Button: Button = root.find_node('Send-Button')
onready var Connect_Button: Button = root.find_node('Connect-Button')
