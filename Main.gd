extends Node2D



func _on_quitButton_pressed():
  get_tree().quit()


func _on_newGameButton_pressed():
  get_tree().change_scene("res://world.tscn")
