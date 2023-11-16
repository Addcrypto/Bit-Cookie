extends Node2D

onready var gunshot = $GunShot

func _on_FullScreenCheckBox_pressed():
    OS.window_fullscreen = !OS.window_fullscreen



func _on_backButton_pressed():
    get_tree().change_scene("res://src/menus/MainMenu.tscn")


func _on_FullScreenCheckBox2_pressed():
    OS.window_fullscreen = !OS.window_fullscreen




func _on_Master_value_changed(value):
  AudioServer.set_bus_volume_db(0, value)


func _on_Sound_FX_value_changed(value):
  AudioServer.set_bus_volume_db(1, value)


func _on_Music_value_changed(value):
  AudioServer.set_bus_volume_db(2, value)


func _on_Sound_FX_drag_ended(value_changed):
  gunshot.play()
