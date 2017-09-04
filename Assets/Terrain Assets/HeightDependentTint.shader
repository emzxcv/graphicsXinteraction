//Sourced from http://answers.unity3d.com/questions/54313/shader-rgb-colour-based-on-y-value-vertex.html
//
 Shader "Custom/HeightDependentTint" 
 {
   Properties 
   {
     _MainTex ("Base (RGB)", 2D) = "white" {}
     _HeightMin ("Height Min", Float) = -1
     _HeightMid ("Height Midway", Float) = 0.5
     _HeightTip ("Height Tip", Float) = 0.8
     _HeightMax ("Height Max", Float) = 1

     _ColorMin ("Tint Color At Min", Color) = (0,0,0,1)
     _ColorMid ("Tint Color At Mid", Color) = (0,0,0,1)
     _ColorTip ("Tint Color At Tip", Color) = (0,0,0,1)
     _ColorMax ("Tint Color At Max", Color) = (1,1,1,1)
   }
  
   SubShader
   {
     Tags { "RenderType"="Opaque" }
  
     CGPROGRAM
     #pragma surface surf Lambert

     sampler2D _MainTex;
     fixed4 _ColorMin;
     fixed4 _ColorMid;
     fixed4 _ColorTip;
     fixed4 _ColorMax;
     float _HeightMin;
     float _HeightMid;
     float _HeightTip;
     float _HeightMax;
  
     struct Input
     {
       float2 uv_MainTex;
       float3 worldPos;
     };

     void surf (Input IN, inout SurfaceOutput o) 
     {
 		     if (IN.worldPos.y >= _HeightMax)
            o.Albedo = _ColorMax;
        if (IN.worldPos.y <= _HeightMax)
            o.Albedo = lerp(_ColorTip.rgba, _ColorMax.rgba, (IN.worldPos.y - _HeightTip)/(_HeightMax - _HeightTip));
        if (IN.worldPos.y <= _HeightTip)
            o.Albedo = lerp(_ColorMid.rgba, _ColorTip.rgba, (IN.worldPos.y - _HeightMid)/(_HeightTip - _HeightMid));
        if (IN.worldPos.y <= _HeightMid)
            o.Albedo = lerp(_ColorMin.rgba, _ColorMid.rgba, (IN.worldPos.y - _HeightMin)/(_HeightMid - _HeightMin));
//        if (IN.worldPos.y <= _WaterLevel)
//            o.Albedo = _WaterColor;
    }
     ENDCG
   } 
   Fallback "Diffuse"
 }
