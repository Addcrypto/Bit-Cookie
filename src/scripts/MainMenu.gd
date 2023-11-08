extends Node2D



func _on_quitButton_pressed():
  get_tree().quit()


# TODO: More elegant logic for selecting level 1 maybe?
func _on_newGameButton_pressed():
  get_tree().change_scene("res://src/levels/Test1.tscn")


func _on_settingsButton_pressed():
    get_tree().change_scene("res://src/menus/OptionsMenu.tscn")



func _on_backButton_pressed():
    get_tree().change_scene("res://src/menus/MainMenu.tscn")


func _on_creditsButton_pressed():
    get_tree().change_scene("res://src/menus/CreditsScene.tscn")
