extends RichTextLabel

signal give_controller_answer(given_answer)

var trig_functions := ["sin", "cos", "tan", "csc", "sec", "cot"]
var basic_theta_bank := ["0", "π/2", "3π/2", "2π", "π/6", "π/3", "π/4"]
var selected_functions := "none"
var selected_theta := "none"

#Answer look up
var look_up_sin := {
	"0": "0",
	"π/2": "1",
	"π": "0",
	"3π/2": "-1",
	"2π": "0",
	"π/6": "1/2",
	"π/3": "√(3)/2",
	"π/4": "√(2)/2"
}

var look_up_cos := {
	"0": "1",
	"π/2": "0",
	"π": "-1",
	"3π/2": "0",
	"2π": "1",
	"π/6": "√(3)/2",
	"π/3": "1/2",
	"π/4": "√(2)/2"
}

var look_up_tan := {
	"0": "0",
	"π/2": "\\",
	"π": "0",
	"3π/2": "\\",
	"2π": "0",
	"π/6": "√(3)/3",
	"π/3": "√(3)",
	"π/4": "1"
}

var look_up_csc := {
	"0": "\\",
	"π/2": "1",
	"π": "\\",
	"3π/2": "-1",
	"2π": "\\",
	"π/6": "2",
	"π/3": "2√(3)/3",
	"π/4": "√(2)"
}

var look_up_sec := {
	"0": "1",
	"π/2": "\\",
	"π": "-1",
	"3π/2": "\\",
	"2π": "1",
	"π/6": "2√(3)/3",
	"π/3": "2",
	"π/4": "√(2)"
}

var look_up_cot := {
	"0": "\\",
	"π/2": "0",
	"π": "\\",
	"3π/2": "0",
	"2π": "\\",
	"π/6": "√(3)",
	"π/3": "√(3)/3",
	"π/4": "1"
}

var question := "none"
var answer := "none"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generate_new_answer()
	clear()
	add_text(question)
	self.add_theme_font_size_override("normal_font_size", 140)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func pick_function():
	selected_functions = trig_functions.pick_random()

func pick_theta():
	selected_theta = basic_theta_bank.pick_random()

func find_answer():
	if (selected_functions == "sin"):
		answer = look_up_sin[selected_theta]
	if (selected_functions == "cos"):
		answer = look_up_cos[selected_theta]
	if (selected_functions == "tan"):
		answer = look_up_tan[selected_theta]
	if (selected_functions == "csc"):
		answer = look_up_csc[selected_theta]
	if (selected_functions == "sec"):
		answer = look_up_sec[selected_theta]
	if (selected_functions == "cot"):
		answer = look_up_cot[selected_theta]
	
	give_controller_answer.emit(answer)

func generate_new_answer():
	pick_function()
	pick_theta()
	find_answer()
	
	question = selected_functions + "(" + selected_theta + ")"
	clear()
	add_text(question)
	

# 0, pi/2, 3pi/2, 2pi, pi/6, pi/3, or pi/4
# But adding pi/2*k makes it harder. So I'll ignore it for it now. 


func _on_controller_call_generate_new_answer() -> void:
	print("call for new answer")
	generate_new_answer()
