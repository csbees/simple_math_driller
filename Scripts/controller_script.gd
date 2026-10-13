extends Node2D

signal change_bg_white
signal change_bg_red
signal change_bg_green

signal ask_for_input
signal call_generate_new_answer

signal wrong_answer(correct_answer: String)

var answer := "none"
var user_asnwer := "none"

var green_bg_timer : float = 0.0
enum BACKGROUND_STATE {
	WHITE, GREEN, RED
}
var current_bg_state := BACKGROUND_STATE.WHITE

func _process(delta: float) -> void:
	
	if (user_asnwer != "none"):
		if (answer == user_asnwer):
				answer_correct()
				user_asnwer = "none"
		else:
			answer_incorrect()
	
	
	if (current_bg_state == BACKGROUND_STATE.GREEN):
		print(green_bg_timer)
		if (green_bg_timer < 1):
			background_reset()
			generate_new_answer()
			current_bg_state = BACKGROUND_STATE.WHITE
		else: 
			switch_bg_timer(delta)
	
	if (Input.is_action_just_pressed("Enter")):
		if (current_bg_state == BACKGROUND_STATE.RED):
			current_bg_state = BACKGROUND_STATE.WHITE
			change_bg_white.emit()
			generate_new_answer()
		elif (current_bg_state != BACKGROUND_STATE.GREEN):
			ask_for_input.emit()

func generate_new_answer():
	print("someone called me")
	call_generate_new_answer.emit()

func background_reset():
	change_bg_white.emit()

func answer_correct():
	print("in answer_correct")
	change_bg_green.emit()
	green_bg_timer = 2
	current_bg_state = BACKGROUND_STATE.GREEN
	$"../correct".play()
func answer_incorrect():
	print("wrong")
	$"../wrong".play()
	change_bg_red.emit()
	current_bg_state = BACKGROUND_STATE.RED
	wrong_answer.emit(answer)
	user_asnwer = "none"

func switch_bg_timer(delta: float):
	if (green_bg_timer > 1):
		green_bg_timer -= delta


func _on_problem_give_controller_answer(given_answer) -> void:
	answer = given_answer

func _on_enter_answer_give_control_input(input: String) -> void:
	input = input.strip_edges()
	user_asnwer = input
