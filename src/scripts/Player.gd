extends KinematicBody2D

# Player health
export var health = 100;
# Acceleration due to gravity
export var gravity: float = 3000
# Maximum horizontal walk speed
export var walk_speed: float = 500
# How quickly player accelerates to max walk speed
export var walk_accel: float = 8000
# How quickly walk speed falls off with no input
export var friction: float = 32
# How high player can jump
export var jump_height: float = 13
# How much faster we move while sprinting
export var sprint_mult: float = 1.45

export var coin_cnt = 0

# signal for damage and death and threaten to reset
export var health_gone = 0

# A reciver variable for power ups
export var power_up_signal = 0
# time that a power up should last
export var timer_duration = 3

# How aggressively jumps will be cut short when the player releases
# the jump button
export var jump_term_mult: float = 4
# Minimum time between jumps in seconds
export var jump_debounce: float = .2
# How long, in seconds, are jumps still accepted after leaving the ground
export var coyote_time: float = .15

# Timestamp of when we last jumped
var last_jumped: float = 0
# Timestamp of when we were last grounded
var last_grounded: float = 0
# Current player velocity
var velocity: Vector2 = Vector2.ZERO

onready var sprite = $Sprite

func _get_input_vector():
    var input_vector = Vector2.ZERO
    input_vector.x = (Input.get_action_strength("move_right")
                    - Input.get_action_strength("move_left"))
    input_vector.y = 1 if Input.is_action_pressed("jump") else 0

    return input_vector
    
func _update_animation(input_vector):
    #if !is_on_floor():
        #animated_sprite.play("jump")
    #elif input_vector.x != 0:
        #animated_sprite.play("run")
    #else:
        #animated_sprite.play("idle")
    
    # Player sprite faces current move direction
    if input_vector.x != 0:
        sprite.flip_h = true if input_vector.x < 0 else false

func _physics_process(dt):
    var input_vector = _get_input_vector()
    var sprint = sprint_mult if Input.is_action_pressed("sprint") else 1

    if input_vector.x != 0:
        velocity.x += input_vector.x * walk_accel * dt
    else:
        # Friction falloff
        velocity.x = lerp(0, velocity.x, pow(2, -friction*dt))
        
    velocity.x = clamp(velocity.x, -walk_speed*sprint, walk_speed*sprint)

    if velocity.y < 0 && input_vector.y == 0:
        # Cut jump short if the player isn't holding the jump button
        velocity.y += gravity * jump_term_mult * dt
    else:
        velocity.y += gravity * dt
        
    if is_on_floor():
        last_grounded = OS.get_ticks_msec()

    var grounded = OS.get_ticks_msec() - last_grounded < coyote_time*1000
    var not_debounced = OS.get_ticks_msec() - last_jumped > jump_debounce*1000
    var can_jump = grounded && not_debounced
    var jump_requested = input_vector.y > 0

    if jump_requested && can_jump:
        # Coyote time should end immediately if we jump
        last_grounded = 0
        # Get force required to launch player to jump_height
        velocity.y = jump_height * 2 * -sqrt(gravity)
        last_jumped = OS.get_ticks_msec()

    velocity = move_and_slide(velocity, Vector2.UP)

    _update_animation(input_vector)

# if called (from powerup) it will increase jump height for (time_duration) and resets it
func Powerup_jump():
  if power_up_signal == 1 && coin_cnt == 3:
    #var prevjump = jump_height
    jump_height *= 1.5
    coin_cnt -= 3
    power_up_signal == 0
    #print(jump_height)
    #yield(get_tree().create_timer(timer_duration), "timeout")
    #jump_height = prevjump

func Powerup_sprint():
  if power_up_signal == 1 && coin_cnt == 5:
    walk_speed *= 1.5
    coin_cnt -= 5

    # these 2 functions are for health and reseting the health (die condition)
func die():
  if (health <= 0):
    print(health)
    get_tree().reload_current_scene()
# (losing health)
func check_on_player():
  if (health_gone == 1):
    health = health - 10 
    health_gone = 0
    print(health)
