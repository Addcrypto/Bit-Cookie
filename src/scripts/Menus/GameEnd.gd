extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func set_title(win: bool):
    if(win):
       $PanelContainer/MarginContainer/Rows/Title.text = "YOU WON"

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass


func _on_Restart_pressed():
    PlayerVariables.Reset()
    get_tree().paused = false
    var _temp = get_tree().change_scene("res://src/levels/Test1.tscn")
    pass # Replace with function body.


func _on_Quit_pressed():
    get_tree().paused = false
    var _temp = get_tree().change_scene("res://src/menus/CreditScene.tscn")
    pass # Replace with function body.
