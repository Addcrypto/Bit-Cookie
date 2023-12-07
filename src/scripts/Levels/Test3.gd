extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const GameOverScreen = preload("res://src/menus/GameEnd.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.

func _on_Player_Died():
    handle_player_dead()
    pass # Replace with function body.

func handle_player_dead():
    var game_over = GameOverScreen.instance()
    add_child(game_over)
    game_over.set_title(false)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
