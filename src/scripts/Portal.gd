extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var Open = false
var Changing = false
export var LevelTo = "MainMenu.tscn"

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass


#Level 10

func _on_Root_child_exiting_tree(node):
    print(node)
    if(node.get_name() == "Portal"):
        Changing = true
    if(node.is_in_group("Enemies") and not Changing):
        print("kill")
        if(get_tree().get_nodes_in_group("Enemies").size() <= 1):
            print("Empty")
            Open = true
    pass # Replace with function body.


func _on_Portal_body_entered(body):
    if(body.name == "Player" and Open):
        var _temp = get_tree().change_scene("res://src/levels/"+LevelTo)
    pass # Replace with function body.
