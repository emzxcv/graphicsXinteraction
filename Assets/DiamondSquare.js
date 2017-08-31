#pragma strict

var divisions : int;
var size : float;
var height : float;

private var vertices : Vector3[];
private var numVertices : int;

private var cameraStartVertex : Vector3;

function Start () {
	InitTerrain();
	findCameraStartVertex();
	setCameraPosition();
}

/*
Initialize the flat plane that will define a terrain. The plane is defined by a mesh
which in turn is defined by vertices, UV's and triangles, all of which are Initialized
in this function.

The diamond-square algorithm will make changes to plane generated by this function.
*/
function InitTerrain() {
	numVertices = (divisions + 1) * (divisions + 1);
	vertices = new Vector3[numVertices];

	var UVs : Vector2[] = new Vector2[numVertices];
	var triangles : int[] = new int[divisions * divisions * 6];

	var halfTerrainSize : float = size / 2;
	var divisionSize : float = size / divisions;

	var mesh : Mesh = new Mesh();
	GetComponent.<MeshFilter>().mesh = mesh;
	GetComponent.<MeshCollider>().sharedMesh = mesh;
	GetComponent.<MeshCollider>().isTrigger = true;

	var triangleOffset : int = 0;

	for (var i = 0; i <= divisions; i++) {
		for (var j = 0; j <= divisions; j++) {
			vertices[i * (divisions+1) + j] = new Vector3(-halfTerrainSize + j * divisionSize, 0.0f, halfTerrainSize - i * divisionSize);
			UVs[i * (divisions+1) + j] = new Vector2(parseFloat(i / divisions), parseFloat(j / divisions));

			if (i < divisions && j < divisions) {
				var topLeft : int = i * (divisions + 1) + j;
				var bottomLeft : int = (i + 1) * (divisions + 1) + j;

				// First triangle of square
				triangles[triangleOffset] = topLeft;
				triangles[triangleOffset + 1] = topLeft + 1;
				triangles[triangleOffset + 2] = bottomLeft + 1;

                // Second triangle of square
				triangles[triangleOffset + 3] = topLeft;
				triangles[triangleOffset + 4] = bottomLeft + 1;
				triangles[triangleOffset + 5] = bottomLeft;

				triangleOffset += 6;
			}
		}
	}

	initDiamondSquareCornerVertices();

	performDiamondSquare();

	mesh.vertices = vertices;
	mesh.uv = UVs;
	mesh.triangles = triangles;

	mesh.RecalculateBounds();
	mesh.RecalculateNormals();
}

/*
The first step of the diamond square algorithm is setting the inital values of the
corner values. This is performed in this function.
*/
function initDiamondSquareCornerVertices(){
	vertices[0].y = Random.Range(-height, height); // top left corner
	vertices[divisions].y = Random.Range(-height, height); // top right corner
	vertices[vertices.length - 1].y = Random.Range(-height, height); // bottom right corner
	vertices[vertices.length - 1 - divisions].y = Random.Range(-height, height); // bottom left corner


}

function findCameraStartVertex() {
	var tmp : Vector3[] = [vertices[0], vertices[divisions], vertices[vertices.length - 1], vertices[vertices.length - 1 - divisions]];
	var lowest : Vector3 = tmp[0];
	for (var i = 0; i < tmp.length; i++){
		if (tmp[i].y < lowest.y){
			lowest = tmp[i];
		}
	}

	ArrayUtility.Remove(tmp, lowest);

	lowest = tmp[0];
	for (i = 0; i < tmp.length; i++){
		if (tmp[i].y < lowest.y){
			lowest = tmp[i];
		}
	}

	cameraStartVertex = lowest;
}

function performDiamondSquare(){
	var numIterations : int = parseInt(Mathf.Log(divisions, 2)); // number of iterations of algorithm
	var numSquares : int = 1;
	var squareSize : int = divisions;

	for (var i = 0; i < numIterations; i++){ // the iteration we're on
		var row : int = 0;

		for (var j = 0; j < numSquares; j++){
			var column : int = 0;

			for (var k = 0; k < numSquares; k++) {
				diamondSquareStep(row, column, squareSize, height);
				column += squareSize;
			}

			row += squareSize;
		}

		numSquares *= 2;
		squareSize /= 2;
		height *= 0.4f;
	}
}

function diamondSquareStep(row : int, column : int, size : int, offset : float) {

	var halfSize : int = parseInt(size * 0.5f);
	var topLeft : int = row * (divisions + 1) + column;
	var bottomLeft : int = (row + size) * (divisions + 1) + column;
	var middle : int = parseInt((row + halfSize) * (divisions + 1) + parseInt(column + halfSize));

    //Calculate height of vertice at middle
	vertices[middle].y = (vertices[topLeft].y + vertices[topLeft + size].y + vertices[bottomLeft].y + vertices[bottomLeft+size].y) / 4 + Random.Range(-offset, offset);

    //square step...
	vertices[topLeft + halfSize].y = (vertices[topLeft].y + vertices[topLeft + size].y + vertices[middle].y) / 3 + Random.Range(-offset, offset);
	vertices[middle - halfSize].y = (vertices[topLeft].y + vertices[bottomLeft].y + vertices[middle].y) / 3 + Random.Range(-offset, offset);
	vertices[middle + halfSize].y = (vertices[topLeft + size].y + vertices[bottomLeft + size].y + vertices[middle].y) / 3 + Random.Range(-offset, offset);
	vertices[bottomLeft + halfSize].y = (vertices[bottomLeft].y + vertices[bottomLeft + size].y + vertices[middle].y) / 3 + Random.Range(-offset, offset);
}

function setCameraPosition() {
	var camera = GameObject.Find("Camera");
	var rotY : float;

	if (Mathf.Approximately(cameraStartVertex.x, 25.0f) && Mathf.Approximately(cameraStartVertex.z, -25.0f)) {
		rotY = -45.0f;
	} else if (Mathf.Approximately(cameraStartVertex.x, -25.0f) && Mathf.Approximately(cameraStartVertex.z, -25.0f)) {
		rotY = 45.0f;
	} else if (Mathf.Approximately(cameraStartVertex.x, 25.0f) && Mathf.Approximately(cameraStartVertex.z, 25.0f)) {
		rotY = -135.0f;
	} else if (Mathf.Approximately(cameraStartVertex.x, -25.0f) && Mathf.Approximately(cameraStartVertex.z, 25.0f)) {
		rotY = 135.0f;
	}

	camera.transform.position = new Vector3(cameraStartVertex.x, cameraStartVertex.y + 10, cameraStartVertex.z);
	camera.transform.rotation = Quaternion.Euler(0.0f, rotY, 0.0f);
}
