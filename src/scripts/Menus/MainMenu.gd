extends Node2D

onready var buttonclick = $ButtonClick

func _ready():
    var file = File.new()
    if(not OptionVariables.Opened):
        if(file.file_exists("user://OptionData.txt")):
            file.open("user://OptionData.txt", file.READ)
            var temp = file.get_csv_line()
            if(temp[0].to_lower() == "true"):
                OptionVariables.Fullscreen = true
                OS.window_fullscreen = true
            OptionVariables.MasterValue = float(temp[1])
            OptionVariables.MusicValue = float(temp[2])
            OptionVariables.FXValue = float(temp[3])
            
            _SetAudio(temp)
        else:
            file.open("user://OptionData.txt", file.WRITE)
            file.store_string("false,0,0,0")
        file.close()
        OptionVariables.Opened = true

func _SetAudio(values):
    AudioServer.set_bus_volume_db(0, float(values[1]))
    AudioServer.set_bus_volume_db(1, float(values[3]))
    AudioServer.set_bus_volume_db(2, float(values[2]))

func _on_quitButton_pressed():
    get_tree().quit()
    buttonclick.play() 
# TODO: More elegant logic for selecting level 1 maybe?
func _on_newGameButton_pressed():
    PlayerVariables.Reset()
    var _temp = get_tree().change_scene("res://src/levels/Test2.tscn")
    buttonclick.play() 
func _on_settingsButton_pressed():
    var _temp = get_tree().change_scene("res://src/menus/OptionsMenu.tscn")
    buttonclick.play() 
func _on_backButton_pressed():
    var _temp = get_tree().change_scene("res://src/menus/MainMenu.tscn")
    buttonclick.play() 
func _on_creditsButton_pressed():
    buttonclick.play()  
    var _temp = get_tree().change_scene("res://src/menus/CreditScene.tscn")
    buttonclick.play() 


