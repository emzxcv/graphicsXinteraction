Shader "Custom/Terrain" {
	Properties {

	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 100
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		const static int maxColourCount = 8;

		int baseColourCount;
		float3 baseColours[maxColourCount];
		float baseStartHeights[maxColourCount];

		float minHeight;
		float maxHeight;

		struct Input {
			//GETS the world height of the surface at that point
			float3 worldPos;
		};

		float inverseLerp(float a, float b, float value) {
			return saturate((value-a)/(b-a));
		}

		void surf (Input IN, inout SurfaceOutputStandard o) {
			
			float heightPercent = inverseLerp(minHeight,maxHeight, IN.worldPos.y);
			for (int i = 0; i < baseColourCount; i ++) {
				float drawStrength = saturate(sign(heightPercent - baseStartHeights[i]));
				o.Albedo = o.Albedo * (1-drawStrength) + baseColours[i] * drawStrength;
			}
			//o.Albedo = float3(1,0,0);

		}


		ENDCG
	}
	FallBack "Diffuse"
}