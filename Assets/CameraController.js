#pragma strict

//Sensitivities...
var translationSensitivity : float = 15.0f;
var pitchYawSensitivity : float = 5.0f;
var rollSensitivity : float = 100.0f;

//Pitch, yaw, roll variables...
private var mouseX : float;
private var mouseY : float;
private var localRotation : Quaternion;
private var rotY : float;
private var rotX : float;
private var rotZ : float;

private var terrain : GameObject;
private var terrainScript : DiamondSquare;

function Start () {
	rotX = 0;
	rotZ = 0;
}

private var minX = -25;
private var maxX = 25;
private var minZ = -25;
private var maxZ = 25;

function Update () {
	var trans : Vector3;
    var w;
	var a;
	var s;
	var d;

	ensure();
	localRotation = Quaternion.Euler(rotX, rotY, rotZ);

	//Pitch and yaw...
	mouseX = Input.GetAxis("Mouse X");
	mouseY = -Input.GetAxis("Mouse Y");
    rotY += mouseX * pitchYawSensitivity;
	rotX += mouseY * pitchYawSensitivity;
	localRotation = Quaternion.Euler(rotX, rotY, rotZ);
	transform.rotation = localRotation;

    //Roll...
	if(Input.GetKey(KeyCode.Q)) {
		rotZ += Time.deltaTime * rollSensitivity;
		localRotation = Quaternion.Euler(rotX, rotY, rotZ);
		transform.rotation = localRotation;
	}
	if(Input.GetKey(KeyCode.E)) {
		rotZ -= Time.deltaTime * rollSensitivity;
		localRotation = Quaternion.Euler(rotX, rotY, rotZ);
		transform.rotation = localRotation;
	}

	//Translation...
	 if(Input.GetKey(KeyCode.D)) {
		 trans = new Vector3(translationSensitivity * Time.deltaTime,0,0);
     }
     if(Input.GetKey(KeyCode.A)) {
		 trans = new Vector3(-translationSensitivity * Time.deltaTime,0,0);
     }
     if(Input.GetKey(KeyCode.S)) {
		 trans = new Vector3(0,0,-translationSensitivity * Time.deltaTime);
     }
     if(Input.GetKey(KeyCode.W)) {
		 trans = new Vector3(0,0,translationSensitivity * Time.deltaTime);
     }

	 //Check collisions
     w = checkCollisionImminent(Vector3.forward);
     s = checkCollisionImminent(Vector3.back);
     a = checkCollisionImminent(Vector3.left);
     d = checkCollisionImminent(Vector3.right);

     //Do nothing if there is a collision
     if(w || s || a || d) {
         return;
     }

     transform.Translate(trans);
	 outOfBounds();
}

function ensure() {
	if (Mathf.Approximately(transform.rotation[1], 0.9238796f)){
		rotY = 135.0f;
	} else if (Mathf.Approximately(transform.rotation[1], -0.9238796f)) {
		rotY = -135.0f;
	} else if (Mathf.Approximately(transform.rotation[1], 0.3826835f)) {
		rotY = 45.0f;
	} else if (Mathf.Approximately(transform.rotation[1], -0.3826835)) {
		rotY = -45.0f;
	}
}

function checkCollisionImminent(direction : Vector3) {
	return Physics.Raycast(transform.position, direction, 10);
}

function outOfBounds() {
	if (transform.position.x < minX) {
		transform.position.x = minX;
	}
	if (transform.position.x > maxX) {
		transform.position.x = maxX;
	}
    if (transform.position.z < minZ) {
		transform.position.z = minZ;
	} if (transform.position.z > maxZ) {
		transform.position.z = maxZ;
	}
}
