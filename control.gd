extends Control

enum FILL {NONE, FIRST_NUMBER, SECOND_NUMBER}
enum SYMBOL {NONE, PLUS, MINUS, MULTIPLY, DIVIDE, MODULUS}	

var state = FILL.NONE
var first_number : Array = []
var second_number : Array = []
var symbol = SYMBOL.NONE

onready var line_edit : LineEdit = $LineEdit

func _process(_delta):
	print(state)
	print(first_number)
	print(second_number)
#	pass

func _on_number_button_down():
	if state == FILL.NONE:
		state = FILL.FIRST_NUMBER

func _on_1_button_down():
	var number = 1
	print_to_line_edit(number)
	append_to_number(number)
	
func print_to_line_edit(value):
	line_edit.text += String(value)

func append_to_number(number : int):
	if state == FILL.FIRST_NUMBER or state == FILL.NONE:
		first_number.append(number)
	elif state == FILL.SECOND_NUMBER:
		second_number.append(number)
	
func _on_2_button_down():
	var number = 2
	print_to_line_edit(number)
	append_to_number(number)
	
func _on_3_button_down():
	var number = 3
	print_to_line_edit(number)
	append_to_number(number)

func _on_4_button_down():
	var number = 4
	print_to_line_edit(number)
	append_to_number(number)

func _on_5_button_down():
	var number = 5
	print_to_line_edit(number)
	append_to_number(number)

func _on_6_button_down():
	var number = 6
	print_to_line_edit(number)
	append_to_number(number)

func _on_7_button_down():
	var number = 7
	print_to_line_edit(number)
	append_to_number(number)

func _on_8_button_down():
	var number = 8
	print_to_line_edit(number)
	append_to_number(number)

func _on_9_button_down():
	var number = 9
	print_to_line_edit(number)
	append_to_number(number)

func _on_0_button_down():
	if state != FILL.NONE:
		var number = 0
		print_to_line_edit(number)
		append_to_number(number)

func _on_plus_button_down():
	if is_allow_to_write_symbol():
		print_to_line_edit("+")
		symbol = SYMBOL.PLUS
		state = FILL.SECOND_NUMBER
		
func is_allow_to_write_symbol() -> bool:
	return (symbol == SYMBOL.NONE and
		state == FILL.FIRST_NUMBER)
		
func _on_minus_button_down():
	if is_allow_to_write_symbol():
		print_to_line_edit("-")
		symbol = SYMBOL.MINUS
		state = FILL.SECOND_NUMBER

func _on_multiply_button_down():
	if is_allow_to_write_symbol():
		print_to_line_edit("x")
		symbol = SYMBOL.MULTIPLY
		state = FILL.SECOND_NUMBER

func _on_divide_button_down():
	if is_allow_to_write_symbol():
		print_to_line_edit("-")
		symbol = SYMBOL.DIVIDE
		state = FILL.SECOND_NUMBER

func _on_result_button_down():
	if state == FILL.SECOND_NUMBER:
		var local_first_number = convert_array_to_int(first_number)
		var local_second_number = convert_array_to_int(second_number)
		
		var result = get_result(
			local_first_number, local_second_number)
			
		line_edit.text = String(result)
		set_state_to_first_number()
		set_result_to_first_number(result)

func convert_array_to_int(array_value : Array) -> int:
	var string_value = ""
	for a in array_value:
		string_value += String(a)
	
	var int_value = 0
	if is_minus_value(array_value):
		int_value = -int(string_value)
	else:
		int_value = int(string_value)
		
	return int_value

func is_minus_value(array_value : Array) -> bool:
	return array_value[0] == 0

func get_result(
	local_first_number : int, local_second_number : int) -> int:
		match symbol:
			SYMBOL.PLUS:
				return local_first_number + local_second_number
			SYMBOL.MINUS:
				return local_first_number - local_second_number
			SYMBOL.MULTIPLY:
				return local_first_number * local_second_number
			SYMBOL.DIVIDE:
				return int(local_first_number / local_second_number)
		return 0
	
func set_state_to_first_number():
	state = FILL.FIRST_NUMBER
	symbol = SYMBOL.NONE
	
func set_result_to_first_number(result : int):
	if result == 0:
		_on_reset_button_down()
	
	first_number = []
	second_number = []
	for fn in String(result):
		first_number.append(int(fn))

func _on_reset_button_down():	
	# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()

func _on_backspace_button_down():
	# prevent remove symbol
	if state == FILL.SECOND_NUMBER and second_number == []:
		return
		
	if state == FILL.FIRST_NUMBER:
		line_edit.text = line_edit.text.substr(
			0, len(line_edit.text) - 1)
		var last_value = first_number.size() - 1
		first_number.remove(last_value)
	elif state == FILL.SECOND_NUMBER:
		line_edit.text = line_edit.text.substr(
			0, len(line_edit.text) - 1)
		var last_value = second_number.size() - 1
		second_number.remove(last_value)
