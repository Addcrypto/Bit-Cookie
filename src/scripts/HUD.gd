extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
    $CoinAmount.text = String(PlayerVariables.Coins)
    $HealthBar.value = PlayerVariables.Health
    
    if(PlayerVariables.jump>13):
        $Items/Panel/HBoxContainer/Jump.texture = load("res://assets/items/HotBar/IconPowerupJump.png")
        $Items/Panel/HBoxContainer/Jump/Label.text = String(PlayerVariables.Spring)
    if(PlayerVariables.speed>500):
        $Items/Panel/HBoxContainer/Speed.texture = load("res://assets/items/HotBar/IconPowerupSpeed.png")
        $Items/Panel/HBoxContainer/Speed/Label.text = String(PlayerVariables.Can)
    print("HUD Updated")
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass


func _on_Player_CoinAmountChanged():
    $CoinAmount.text = String(PlayerVariables.Coins)
    print("HUD Updated")
    pass # Replace with function body.


func _on_Player_HealthAmountChanged():
    $HealthBar.value = PlayerVariables.Health
    print("HUD Updated")
    pass # Replace with function body.


func _on_Player_JumpGained():
    $Items/Panel/HBoxContainer/Jump.texture = load("res://assets/items/HotBar/IconPowerupJump.png")
    $Items/Panel/HBoxContainer/Jump/Label.text = String(PlayerVariables.Spring)
    pass # Replace with function body.


func _on_Player_SpeedGained():
    $Items/Panel/HBoxContainer/Speed.texture = load("res://assets/items/HotBar/IconPowerupSpeed.png")
    $Items/Panel/HBoxContainer/Speed/Label.text = String(PlayerVariables.Can)
    pass # Replace with function body.
