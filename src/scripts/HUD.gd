extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
    $CoinAmount.text = String(PlayerVariables.Coins)
    $HealthBar.value = PlayerVariables.Health
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
