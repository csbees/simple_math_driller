extends RichTextLabel


func _on_controller_wrong_answer(answer) -> void:
	clear()
	add_text(answer)
	self.add_theme_font_size_override("normal_font_size", 120)


func _on_controller_change_bg_white() -> void:
	clear()
