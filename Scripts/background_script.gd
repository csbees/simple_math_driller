extends Panel

var styleBox: StyleBoxFlat = get_theme_stylebox("panel")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_controller_change_bg_white() -> void:
	styleBox.set("bg_color", Color(0.481, 0.64, 0.593, 1.0))


func _on_controller_change_bg_red() -> void:
	styleBox.set("bg_color", Color(0.743, 0.111, 0.298, 1.0))


func _on_controller_change_bg_green() -> void:
	styleBox.set("bg_color", Color(0.0, 0.548, 0.383, 1.0))
