#pragma strict

private var vertices : Vector3[];
private var UVs : Vector2[];
private var triangles : int[];

function Start () {
	vertices = new Vector3[4];
	UVs = new Vector2[4];
	triangles = new int[6];

	var mesh : Mesh = new Mesh();
	GetComponent.<MeshFilter>().mesh = mesh;

	initVertices();
	initUVs();
	initTriangles();

	mesh.vertices = vertices;
	mesh.uv = UVs;
	mesh.triangles = triangles;

	mesh.RecalculateBounds();
	mesh.RecalculateNormals();
}

private function initVertices() {
	vertices[0] = new Vector3(-1.0f, 0.0f, 1.0f);
	vertices[1] = new Vector3(1.0f, 0.0f, 1.0f);
	vertices[2] = new Vector3(-1.0f, 0.0f, -1.0f);
	vertices[3] = new Vector3(1.0f, 0.0f, -1.0f);
}

private function initUVs() {
	UVs[0] = new Vector2(0.0f, 0.0f);
	UVs[1] = new Vector2(1.0f, 0.0f);
	UVs[2] = new Vector2(0.0f, 1.0f);
	UVs[3] = new Vector2(1.0f, 1.0f);
}

private function initTriangles() {
	triangles[0] = 0;
	triangles[1] = 1;
	triangles[2] = 3;

	triangles[3] = 0;
	triangles[4] = 3;
	triangles[5] = 2;
}
