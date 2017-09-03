// Compiled shader for PC, Mac & Linux Standalone

//////////////////////////////////////////////////////////////////////////
// 
// NOTE: This is *not* a valid shader file, the contents are provided just
// for information and for debugging purposes only.
// 
//////////////////////////////////////////////////////////////////////////
// Skipping shader variants that would not be included into build of current scene.

Shader "Custom/BasicLightingPerVertex" {
Properties {
 _MainTex ("Main Texture", 2D) = "white" { }
[Header(Ambient)]  _Ambient ("Intensity", Range(0.000000,1.000000)) = 0.100000
 _AmbColor ("Color", Color) = (1.000000,1.000000,1.000000,1.000000)
[Header(Diffuse)]  _Diffuse ("Val", Range(0.000000,1.000000)) = 1.000000
 _DifColor ("Color", Color) = (1.000000,1.000000,1.000000,1.000000)
[Header(Specular)] [Toggle]  _Spec ("Enabled?", Float) = 0.000000
 _Shininess ("Shininess", Range(0.100000,10.000000)) = 1.000000
 _SpecColor ("Specular color", Color) = (1.000000,1.000000,1.000000,1.000000)
[Header(Emission)]  _EmissionTex ("Emission texture", 2D) = "gray" { }
 _EmiVal ("Intensity", Float) = 0.000000
[HDR]  _EmiColor ("Color", Color) = (1.000000,1.000000,1.000000,1.000000)
}
SubShader { 
 Pass {
  Tags { "LIGHTMODE"="FORWARDBASE" "QUEUE"="Geometry" "RenderType"="Opaque" }
  //////////////////////////////////
  //                              //
  //      Compiled programs       //
  //                              //
  //////////////////////////////////
//////////////////////////////////////////////////////
No keywords set in this variant.
-- Vertex shader for "metal":
Uses vertex data channel "Vertex"
Uses vertex data channel "Color"
Uses vertex data channel "TexCoord"

Constant Buffer "Globals" (288 bytes) on slot 0 {
  Matrix4x4 unity_ObjectToWorld at 16
  Matrix4x4 unity_WorldToObject at 80
  Matrix4x4 unity_MatrixVP at 144
  Vector4 _WorldSpaceLightPos0 at 0
  Vector4 _LightColor0 at 208
  Float _Diffuse at 224
  Vector4 _DifColor at 240
  Float _Ambient at 256
  Vector4 _AmbColor at 272
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;
struct Globals_Type
{
    float4 _WorldSpaceLightPos0;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _LightColor0;
    float _Diffuse;
    float4 _DifColor;
    float _Ambient;
    float4 _AmbColor;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 COLOR0 [[ user(COLOR0) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant Globals_Type& Globals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float u_xlat6;
    u_xlat0 = input.POSITION0.yyyy * Globals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = Globals.hlslcc_mtx4x4unity_ObjectToWorld[0] * input.POSITION0.xxxx + u_xlat0;
    u_xlat0 = Globals.hlslcc_mtx4x4unity_ObjectToWorld[2] * input.POSITION0.zzzz + u_xlat0;
    u_xlat0 = Globals.hlslcc_mtx4x4unity_ObjectToWorld[3] * input.POSITION0.wwww + u_xlat0;
    u_xlat1 = u_xlat0.yyyy * Globals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = Globals.hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = Globals.hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    output.mtl_Position = Globals.hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    output.TEXCOORD0.xy = input.TEXCOORD0.xy;
    u_xlat0.x = dot(input.NORMAL0.xyz, Globals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, Globals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, Globals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    u_xlat0.xyz = float3(u_xlat6) * u_xlat0.xyz;
    u_xlat6 = dot(Globals._WorldSpaceLightPos0.xyz, Globals._WorldSpaceLightPos0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    u_xlat1.xyz = float3(u_xlat6) * Globals._WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat0 = u_xlat0.xxxx * Globals._LightColor0;
    u_xlat0 = max(u_xlat0, float4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * float4(Globals._Diffuse);
    u_xlat0 = u_xlat0 * Globals._LightColor0;
    u_xlat1 = float4(Globals._Ambient) * Globals._AmbColor;
    output.COLOR0 = u_xlat0 * Globals._DifColor + u_xlat1;
    return output;
}


-- Fragment shader for "metal":
Set 2D Texture "_MainTex" to slot 0
Set 2D Texture "_EmissionTex" to slot 1

Constant Buffer "Globals" (20 bytes) on slot 0 {
  Vector4 _EmiColor at 0
  Float _EmiVal at 16
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;
struct Globals_Type
{
    float4 _EmiColor;
    float _EmiVal;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 COLOR0 [[ user(COLOR0) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(0) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant Globals_Type& Globals [[ buffer(0) ]],
    texture2d<float, access::sample > _MainTex [[ texture (0) ]] ,
    sampler sampler_MainTex [[ sampler (0) ]] ,
    texture2d<float, access::sample > _EmissionTex [[ texture (1) ]] ,
    sampler sampler_EmissionTex [[ sampler (1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float4 u_xlat1;
    u_xlat0.x = _EmissionTex.sample(sampler_EmissionTex, input.TEXCOORD0.xy).x;
    u_xlat0.xyz = u_xlat0.xxx * Globals._EmiColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * float3(Globals._EmiVal);
    u_xlat1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    output.SV_Target0.xyz = u_xlat1.xyz * input.COLOR0.xyz + u_xlat0.xyz;
    output.SV_Target0.w = u_xlat1.w;
    return output;
}


-- Vertex shader for "glcore":
Shader Disassembly:
#ifdef VERTEX
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable

uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _LightColor0;
uniform 	float _Diffuse;
uniform 	vec4 _DifColor;
uniform 	float _Ambient;
uniform 	vec4 _AmbColor;
in  vec4 in_POSITION0;
in  vec3 in_NORMAL0;
in  vec4 in_TEXCOORD0;
out vec2 vs_TEXCOORD0;
out vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat6 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat1.xyz = vec3(u_xlat6) * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat0 = u_xlat0.xxxx * _LightColor0;
    u_xlat0 = max(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * vec4(_Diffuse);
    u_xlat0 = u_xlat0 * _LightColor0;
    u_xlat1 = vec4(_Ambient) * _AmbColor;
    vs_COLOR0 = u_xlat0 * _DifColor + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable

uniform 	vec4 _EmiColor;
uniform 	float _EmiVal;
uniform  sampler2D _MainTex;
uniform  sampler2D _EmissionTex;
in  vec2 vs_TEXCOORD0;
in  vec4 vs_COLOR0;
layout(location = 0) out vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat10_0;
vec4 u_xlat10_1;
void main()
{
    u_xlat10_0 = texture(_EmissionTex, vs_TEXCOORD0.xy);
    u_xlat0.xyz = u_xlat10_0.xxx * _EmiColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_EmiVal);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat10_1.w;
    return;
}

#endif


-- Fragment shader for "glcore":
Shader Disassembly:
// All GLSL source is contained within the vertex program

//////////////////////////////////////////////////////
Keywords set in this variant: _SPEC_ON 
-- Vertex shader for "metal":
Uses vertex data channel "Vertex"
Uses vertex data channel "Color"
Uses vertex data channel "TexCoord"

Constant Buffer "Globals" (336 bytes) on slot 0 {
  Matrix4x4 unity_ObjectToWorld at 32
  Matrix4x4 unity_WorldToObject at 96
  Matrix4x4 unity_MatrixVP at 160
  Vector3 _WorldSpaceCameraPos at 0
  Vector4 _WorldSpaceLightPos0 at 16
  Vector4 _LightColor0 at 224
  Float _Diffuse at 240
  Vector4 _DifColor at 256
  Float _Shininess at 272
  Vector4 _SpecColor at 288
  Float _Ambient at 304
  Vector4 _AmbColor at 320
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;
struct Globals_Type
{
    float3 _WorldSpaceCameraPos;
    float4 _WorldSpaceLightPos0;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _LightColor0;
    float _Diffuse;
    float4 _DifColor;
    float _Shininess;
    float4 _SpecColor;
    float _Ambient;
    float4 _AmbColor;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 COLOR0 [[ user(COLOR0) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant Globals_Type& Globals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    float u_xlat12;
    u_xlat0 = input.POSITION0.yyyy * Globals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = Globals.hlslcc_mtx4x4unity_ObjectToWorld[0] * input.POSITION0.xxxx + u_xlat0;
    u_xlat0 = Globals.hlslcc_mtx4x4unity_ObjectToWorld[2] * input.POSITION0.zzzz + u_xlat0;
    u_xlat0 = Globals.hlslcc_mtx4x4unity_ObjectToWorld[3] * input.POSITION0.wwww + u_xlat0;
    u_xlat1 = u_xlat0.yyyy * Globals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = Globals.hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = Globals.hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    output.mtl_Position = Globals.hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.xyz = (-u_xlat0.xyz) + Globals._WorldSpaceCameraPos.xyzx.xyz;
    output.TEXCOORD0.xy = input.TEXCOORD0.xy;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.x = dot(input.NORMAL0.xyz, Globals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(input.NORMAL0.xyz, Globals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, Globals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat1.xyz = float3(u_xlat12) * u_xlat1.xyz;
    u_xlat12 = dot(Globals._WorldSpaceLightPos0.xyz, Globals._WorldSpaceLightPos0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat2.xyz = float3(u_xlat12) * Globals._WorldSpaceLightPos0.xyz;
    u_xlat12 = dot((-u_xlat2.xyz), u_xlat1.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat3.xyz = u_xlat1.xyz * (-float3(u_xlat12)) + (-u_xlat2.xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat1 = float4(u_xlat12) * Globals._LightColor0;
    u_xlat1 = max(u_xlat1, float4(0.0, 0.0, 0.0, 0.0));
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * Globals._Shininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0 = u_xlat0.xxxx * Globals._LightColor0;
    u_xlat2 = ceil(u_xlat1);
    u_xlat1 = u_xlat1 * float4(Globals._Diffuse);
    u_xlat1 = u_xlat1 * Globals._LightColor0;
    u_xlat0 = u_xlat0 * u_xlat2;
    u_xlat2 = float4(Globals._Ambient) * Globals._AmbColor;
    u_xlat1 = u_xlat1 * Globals._DifColor + u_xlat2;
    output.COLOR0 = u_xlat0 * Globals._SpecColor + u_xlat1;
    return output;
}


-- Fragment shader for "metal":
Set 2D Texture "_MainTex" to slot 0
Set 2D Texture "_EmissionTex" to slot 1

Constant Buffer "Globals" (20 bytes) on slot 0 {
  Vector4 _EmiColor at 0
  Float _EmiVal at 16
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;
struct Globals_Type
{
    float4 _EmiColor;
    float _EmiVal;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 COLOR0 [[ user(COLOR0) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(0) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant Globals_Type& Globals [[ buffer(0) ]],
    texture2d<float, access::sample > _MainTex [[ texture (0) ]] ,
    sampler sampler_MainTex [[ sampler (0) ]] ,
    texture2d<float, access::sample > _EmissionTex [[ texture (1) ]] ,
    sampler sampler_EmissionTex [[ sampler (1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float4 u_xlat1;
    u_xlat0.x = _EmissionTex.sample(sampler_EmissionTex, input.TEXCOORD0.xy).x;
    u_xlat0.xyz = u_xlat0.xxx * Globals._EmiColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * float3(Globals._EmiVal);
    u_xlat1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    output.SV_Target0.xyz = u_xlat1.xyz * input.COLOR0.xyz + u_xlat0.xyz;
    output.SV_Target0.w = u_xlat1.w;
    return output;
}


-- Vertex shader for "glcore":
Shader Disassembly:
#ifdef VERTEX
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _LightColor0;
uniform 	float _Diffuse;
uniform 	vec4 _DifColor;
uniform 	float _Shininess;
uniform 	vec4 _SpecColor;
uniform 	float _Ambient;
uniform 	vec4 _AmbColor;
in  vec4 in_POSITION0;
in  vec3 in_NORMAL0;
in  vec4 in_TEXCOORD0;
out vec2 vs_TEXCOORD0;
out vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat12 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * _WorldSpaceLightPos0.xyz;
    u_xlat12 = dot((-u_xlat2.xyz), u_xlat1.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat3.xyz = u_xlat1.xyz * (-vec3(u_xlat12)) + (-u_xlat2.xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat1 = vec4(u_xlat12) * _LightColor0;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Shininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0 = u_xlat0.xxxx * _LightColor0;
    u_xlat2 = ceil(u_xlat1);
    u_xlat1 = u_xlat1 * vec4(_Diffuse);
    u_xlat1 = u_xlat1 * _LightColor0;
    u_xlat0 = u_xlat0 * u_xlat2;
    u_xlat2 = vec4(_Ambient) * _AmbColor;
    u_xlat1 = u_xlat1 * _DifColor + u_xlat2;
    vs_COLOR0 = u_xlat0 * _SpecColor + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable

uniform 	vec4 _EmiColor;
uniform 	float _EmiVal;
uniform  sampler2D _MainTex;
uniform  sampler2D _EmissionTex;
in  vec2 vs_TEXCOORD0;
in  vec4 vs_COLOR0;
layout(location = 0) out vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat10_0;
vec4 u_xlat10_1;
void main()
{
    u_xlat10_0 = texture(_EmissionTex, vs_TEXCOORD0.xy);
    u_xlat0.xyz = u_xlat10_0.xxx * _EmiColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_EmiVal);
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat10_1.w;
    return;
}

#endif


-- Fragment shader for "glcore":
Shader Disassembly:
// All GLSL source is contained within the vertex program

 }
}
}