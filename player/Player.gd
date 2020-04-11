extends KinematicBody2D

export var acceleration: float = 50
export var friction: float = 25
export var max_speed: float = 175
var velocity: Vector2 = Vector2.ZERO

onready var animationTree: AnimationTree = $AnimationTree
onready var animationState: AnimationNodeStateMachine = animationTree.get("parameters/playback")

func _physics_process(_delta: float):
  movement_process()

func movement_process():
  var direction: Vector2 = get_input_direction().normalized()

  if direction != Vector2.ZERO:
    set_animation_direction(direction)
    velocity = velocity.move_toward(direction * max_speed, acceleration)
  else:
    velocity = velocity.move_toward(Vector2.ZERO, friction)

  velocity = move_and_slide(velocity)
  animationState.travel("run" if velocity != Vector2.ZERO else "idle")

func set_animation_direction(direction: Vector2):
  if not is_inside_tree():
    return
  animationTree.set("parameters/idle/blend_position", direction)
  animationTree.set("parameters/run/blend_position", direction)

func get_input_direction() -> Vector2:
  var up = int(Input.is_action_pressed("ui_up"))
  var down = int(Input.is_action_pressed("ui_down"))
  var left = int(Input.is_action_pressed("ui_left"))
  var right = int(Input.is_action_pressed("ui_right"))
  return Vector2(right - left, down - up)
