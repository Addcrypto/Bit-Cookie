extends Control

export(int) var speed: int = 150
#export(float) var rotation_speed: float = 0.04

var direction = Vector2(0, -1)

onready var parallax = $creditsBackground

func _process(delta):
    parallax.scroll_offset += direction * speed * delta


func _on_backButton_pressed():
        var _temp = get_tree().change_scene("res://src/menus/MainMenu.tscn")
        
