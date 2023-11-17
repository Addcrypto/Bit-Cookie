extends Node2D



func _on_quitButton_pressed():
  get_tree().quit()


func _on_newGameButton_pressed():
  get_tree().change_scene("res://dummyImport.tscn")


func _on_settingsButton_pressed():
    get_tree().change_scene("res://optionsMenu.tscn")



func _on_backButton_pressed():
    get_tree().change_scene("res://mainMenu.tscn")


func _on_creditsButton_pressed():
    get_tree().change_scene("res://CreditScene.tscn")
