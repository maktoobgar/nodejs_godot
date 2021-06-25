extends Control

var SOCKET_URL = "ws://"
var _client = WebSocketClient.new()


func _ready():
	set_process(false)
	_client.connect("connection_closed", self, "_on_connection_closed")
	_client.connect("connection_error", self, "_on_connection_closed")
	_client.connect("connection_established", self, "_on_connected")
	_client.connect("data_received", self, "_on_data")

func _process(delta):
	_client.poll()

func _on_connection_closed(was_clean = false):
	set_process(false)
	Global.Chat_LineEdit.editable = false
	Global.Username_LineEdit.editable = true
	Global.Address_LineEdit.editable = true
	Global.Send_Button.disabled = true

func _on_connected(proto = ''):
	print('connected with protocol: %s' % proto)

func _on_data():
	var payload = JSON.parse(_client.get_peer(1).get_packet().get_string_from_utf8()).result
	if 'username' in payload:
		Global.Chat_TextEdit.text = (Global.Chat_TextEdit.text + '\n' + 
		payload['username'] + '> ' + payload['text'])

#func _send():
#	_client.get_peer(1).put_packet(JSON.print({"test": "Test"}).to_utf8())

func _on_ConnectButton_button_up():
	if (Global.Connect_Button.text == 'Connect'):
		var err = _client.connect_to_url(SOCKET_URL + Global.Address_LineEdit.text)
		if err != OK:
			_on_connection_closed(false)
			return
		set_process(true)
		Global.Connect_Button.text = "Disconnect"
		Global.Chat_LineEdit.editable = true
		Global.Username_LineEdit.editable = false
		Global.Address_LineEdit.editable = false
		Global.Send_Button.disabled = false
	elif (Global.Connect_Button.text == 'Disconnect'):
		Global.Connect_Button.text = "Connect"
		_client.disconnect_from_host()
		_on_connection_closed(false)

func _on_SendButton_button_up():
	_client.get_peer(1).put_packet(
		JSON.print({
			"username": Global.Username_LineEdit.text,
			"text": Global.Chat_LineEdit.text
		}).to_utf8())

func _on_MaximizeTextureButton_button_up():
	if not OS.is_window_fullscreen():
		OS.set_window_fullscreen(true)
	else:
		OS.set_window_fullscreen(false)

func _on_CloseTextureButton_button_up():
	get_tree().quit(0)

func _on_MiniimizeTextureButton_button_up():
	OS.set_window_minimized(true)
