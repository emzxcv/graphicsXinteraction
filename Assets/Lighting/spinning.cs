using UnityEngine;
using System.Collections;

public class spinning : MonoBehaviour {
	
	Transform target;
	GameObject terrain;

	// Use this for initialization
	void Start () {
		GameObject terrain = GameObject.Find("Terrain");
		target = terrain.transform;
		ChangeRadius (50);
	}

	//Sourced this method from https://forum.unity3d.com/threads/camera-orbiting-around-an-object-choosing-radius-c-transform-rotatearound.337985/

	void ChangeRadius(float amount) {
		//Vector3 direction = transform.position.normalized; // This will only work when rotating around 0,0,0
		Vector3 direction = (transform.position - target.position).normalized; // Use this if target position is not 0,0,0
		transform.Translate(direction * amount);
	}

	// Update is called once per frame
	void Update () 
	{
		transform.RotateAround(Vector3.zero,Vector3.right,50f*Time.deltaTime);
		transform.LookAt(Vector3.zero);
	}
}
