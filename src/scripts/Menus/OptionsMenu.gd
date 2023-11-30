extends Node2D

onready var gunshot = $GunShot
onready var MasterSlider = $ColorRect/HBoxContainer/VBoxContainer2/Master
onready var MusicSlider = $ColorRect/HBoxContainer/VBoxContainer2/Music
onready var FXSlider = $"ColorRect/HBoxContainer/VBoxContainer2/Sound FX"
onready var FullCheck = $ColorRect/HBoxContainer2/VBoxContainer2/FullScreenCheckBox2
onready var MasterValue = OptionVariables.MasterValue
onready var MusicValue = OptionVariables.MusicValue
onready var FXValue = OptionVariables.FXValue
onready var FullValue = OptionVariables.Fullscreen
onready var file = File.new()


func _ready():
    MasterSlider.value = MasterValue
    MusicSlider.value = MusicValue
    FXSlider.value = FXValue
    FullCheck.pressed = FullValue
#    print(MasterSlider.value)
#    print(MusicSlider.value)
#    print(FXSlider.value)
    
    file.open("user://OptionData.txt", file.WRITE)

func _on_FullScreenCheckBox_pressed():
    OS.window_fullscreen = !OS.window_fullscreen
    OptionVariables.Fullscreen = !OptionVariables.Fullscreen

func _on_backButton_pressed():
    var Settings = String(FullCheck.pressed)+","+String(OptionVariables.MasterValue)+","+String(OptionVariables.MusicValue)+","+String(OptionVariables.FXValue)
    file.store_string(Settings)
    file.close()
    var _temp = get_tree().change_scene("res://src/menus/MainMenu.tscn")


func _on_FullScreenCheckBox2_pressed():
    OS.window_fullscreen = !OS.window_fullscreen
    OptionVariables.Fullscreen = !OptionVariables.Fullscreen


func _on_Master_value_changed(value):
  AudioServer.set_bus_volume_db(0, value)
  OptionVariables.MasterValue = value


func _on_Sound_FX_value_changed(value):
  AudioServer.set_bus_volume_db(1, value)
  OptionVariables.FXValue = value


func _on_Music_value_changed(value):
  AudioServer.set_bus_volume_db(2, value)
  OptionVariables.MusicValue = value

func _on_Sound_FX_drag_ended(_value_changed):
  gunshot.play()
