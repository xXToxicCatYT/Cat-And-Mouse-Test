Shader "Custom/SimpleLightingShaderWithTexture"
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
    }

    SubShader
    {
        // Tag to specify the render type as opaque.
        Tags { "RenderType"="Opaque" }
        // Level of detail for the shader.
        LOD 200

        Pass
        {
            CGPROGRAM
            // Specify the vertex and fragment shaders.
            #pragma vertex vert
            #pragma fragment frag

            // Input structure for vertex data.
            struct appdata
            {
                float4 vertex : POSITION;  // Vertex position in object space.
                float3 normal : NORMAL;    // Vertex normal in object space.
                float2 uv : TEXCOORD0;     // UV coordinates for texture mapping.
            };

            // Output structure for vertex data after processing.
            struct v2f
            {
                float4 pos : SV_POSITION;    // Position in clip space.
                float3 normal : TEXCOORD0;   // Normal in world space.
                float3 worldPos : TEXCOORD1; // Position in world space.
                float2 uv : TEXCOORD2;       // UV coordinates.
            };

            // Shader properties
            sampler2D _MainTex;            // Sampler for the main texture.
            float4 _Color;                 // Object color.
            float _AmbientIntensity;       // Ambient light intensity.
            float _DiffuseIntensity;       // Diffuse light intensity.
            float4 _LightColor;            // Color of the light source.
            float4 _LightPosition;         // Position of the light source.

            // Vertex shader
            v2f vert (appdata v)
            {
                v2f o;
                // Transform vertex position to clip space.
                o.pos = UnityObjectToClipPos(v.vertex);
                // Transform normal to world space.
                o.normal = normalize(mul(v.normal, (float3x3)unity_WorldToObject));
                // Calculate world position of the vertex.
                o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
                // Pass UV coordinates to fragment shader.
                o.uv = v.uv;
                return o; // Return processed vertex data.
            }

            // Fragment shader
            float4 frag (v2f i) : SV_Target
            {
                // Sample the texture color at the UV coordinates and multiply by the object color.
                float4 texColor = tex2D(_MainTex, i.uv) * _Color;

                // Calculate ambient lighting.
                float3 ambient = _LightColor.rgb * _AmbientIntensity;

                // Calculate diffuse lighting.
                float3 lightDir = normalize(_LightPosition.xyz - i.worldPos); // Direction from fragment to light.
                float diffuseFactor = max(dot(i.normal, lightDir), 0.0); // Compute diffuse factor using dot product.
                float3 diffuse = _LightColor.rgb * _DiffuseIntensity * diffuseFactor; // Scale by light color and intensity.

                // Combine texture color with ambient and diffuse lighting.
                float3 finalColor = texColor.rgb * (ambient + diffuse);
                return float4(finalColor, texColor.a); // Return final color with texture alpha.
            }
            ENDCG
        }
    }

    // Fallback shader if this shader fails to compile.
    FallBack "Diffuse"
}
