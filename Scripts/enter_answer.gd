extends LineEdit

signal give_control_input(input)

func _ready() -> void:
	self.add_theme_font_size_override("font_size", 90)
	var outline_style := StyleBoxFlat.new()
	
	outline_style.bg_color = Color(0, 0, 0, 0)
	outline_style.set_border_width_all(2)
	outline_style.border_color = Color.WHITE
	add_theme_stylebox_override("normal", outline_style)
	
	grab_focus()

func _process(delta: float) -> void:
	#text_changed.connect(_on_text_changed)
	replace_pi()
	replace_sqrt()

func replace_pi() -> void:
	if "pi" in self.text:
		var caret_pos := caret_column
		text = self.text.replace("pi", "π")
		caret_column = caret_pos - 1

func replace_sqrt() -> void:
	if "sqrt" in self.text:
		var caret_pos := caret_column
		text = self.text.replace("sqrt", "√()")
		
		caret_column = caret_pos - 2


func _on_controller_ask_for_input() -> void:
	if (self.text.strip_edges() == ""):
		return
	give_control_input.emit(self.text)
	clear()
