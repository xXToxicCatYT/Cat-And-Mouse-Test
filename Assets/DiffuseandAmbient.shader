Shader "Custom/SimpleLightingShaderWithTextureAndFog"
{
    Properties
    {
        // The main texture of the object, defaulting to white.
        _MainTex ("Texture", 2D) = "white" {}
        // The color of the object, defaulting to white.
        _Color ("Object Color", Color) = (1,1,1,1)
        // Intensity of the ambient lighting, ranged from 0 to 1.
        _AmbientIntensity ("Ambient Intensity", Range(0, 1)) = 0.2
        // Intensity of the diffuse lighting, ranged from 0 to 1.
        _DiffuseIntensity ("Diffuse Intensity", Range(0, 1)) = 0.8
        // Color of the light source.
        _LightColor ("Light Color", Color) = (1,1,1,1)
        // Position of the light in world space.
        _LightPosition ("Light Position", Vector) = (0, 10, 0, 1)
        // Fog density (adjust for stronger/weaker fog effect).
        _FogDensity ("Fog Density", Range(0, 1)) = 0.8
        // Fog color.
        _FogColor ("Fog Color", Color) = (0.5, 0.5, 0.5, 1)
    }

    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            // Custom properties
            sampler2D _MainTex;            // Sampler for the main texture.
            float4 _Color;                 // Object color.
            float _AmbientIntensity;       // Ambient light intensity.
            float _DiffuseIntensity;       // Diffuse light intensity.
            float4 _LightColor;            // Color of the light source.
            float4 _LightPosition;         // Position of the light source.
            float _FogDensity;             // Fog density.
            float4 _FogColor;              // Fog color.

            // Input structure for the vertex shader
            struct appdata
            {
                float4 vertex : POSITION;  // Vertex position in object space.
                float3 normal : NORMAL;    // Vertex normal in object space.
                float2 uv : TEXCOORD0;     // UV coordinates for texture mapping.
            };

            // Output structure for the vertex shader
            struct v2f
            {
                float4 pos : SV_POSITION;    // Position in clip space.
                float3 normal : TEXCOORD0;   // Normal in world space.
                float3 worldPos : TEXCOORD1; // Position in world space.
                float2 uv : TEXCOORD2;       // UV coordinates.
            };

            // Vertex shader
            v2f vert(appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.normal = normalize(mul(v.normal, (float3x3)unity_WorldToObject));
                o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
                o.uv = v.uv;
                return o;
            }

            // Fragment shader
            half4 frag(v2f i) : SV_Target
            {
                // Sample the base texture color
                half4 texColor = tex2D(_MainTex, i.uv) * _Color;

                // Calculate ambient lighting
                float3 ambient = _LightColor.rgb * _AmbientIntensity;

                // Calculate diffuse lighting
                float3 lightDir = normalize(_LightPosition.xyz - i.worldPos); // Direction from fragment to light.
                float diffuseFactor = max(dot(i.normal, lightDir), 0.0); // Compute diffuse factor.
                float3 diffuse = _LightColor.rgb * _DiffuseIntensity * diffuseFactor;

                // Combine the base texture with ambient and diffuse lighting
                float3 finalColor = texColor.rgb * (ambient + diffuse);

                // Compute fog factor based on distance from the camera
                float dist = length(i.worldPos - _WorldSpaceCameraPos.xyz); // Distance from camera
                float fogFactor = exp(-_FogDensity * dist); // Exponential fog effect
                fogFactor = clamp(fogFactor, 0.0, 1.0); // Clamp the fog factor to [0, 1]

                // Lerp between the final color and the fog color
                finalColor = lerp(finalColor, _FogColor.rgb, 1.0 - fogFactor);

                // Return final color with texture alpha
                return float4(finalColor, texColor.a);
            }

            ENDCG
        }
    }

    Fallback "Diffuse"
}
