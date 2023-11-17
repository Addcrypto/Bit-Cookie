extends Control


func _input(event):
  if event.is_action_pressed("pause"):
    var new_paused_state = not get_tree().paused
    get_tree().paused = new_paused_state
    visible = new_paused_state
    

func _on_quitGame_pressed():
  var _temp = get_tree().change_scene("res://src/menus/MainMenu.tscn")
  get_tree().paused = false


func _on_resumeGame_pressed():
  var new_paused_state = not get_tree().paused
  visible = new_paused_state
  get_tree().paused = false
  
