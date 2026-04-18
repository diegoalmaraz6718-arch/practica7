extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Consigue la gravedad de los ajustes del proyecto para que se sienta natural
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
 # Añadir gravedad si no está en el suelo
 if not is_on_floor():
  velocity.y -= gravity * delta

 # Manejar el Salto
 if Input.is_action_just_pressed("ui_accept") and is_on_floor():
  velocity.y = JUMP_VELOCITY

 # Obtener la dirección de entrada (Flechas o WASD)
 var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
 var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
 if direction:
  velocity.x = direction.x * SPEED
  velocity.z = direction.z * SPEED
 else:
  velocity.x = move_toward(velocity.x, 0, SPEED)
  velocity.z = move_toward(velocity.z, 0, SPEED)

 move_and_slide()

func _input(event):
 # Si presionas la tecla 'R', se reinicia la escena actual
 if event.is_action_pressed("ui_restart") or Input.is_key_pressed(KEY_R):
  get_tree().reload_current_scene()
